{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    darwin,
    home-manager,
    sops-nix,
    deploy-rs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-darwin"
    ];
  in rec {
    formatter = forAllSystems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );

    # Devshell for bootstrapping
    # Acessible through 'nix develop' or 'nix-shell' (legacy)
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./nix/shell.nix {inherit pkgs;}
    );

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      nucIso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nuc/custom-media.nix
          disko.nixosModules.disko
          {
            disko.devices = import ./hosts/nuc/disk-config.nix {
              lib = nixpkgs.lib;
              disks = ["/dev/nvme0n1"];
            };
            boot.loader.grub = {
              devices = ["/dev/nvme0n1"];
              efiSupport = true;
            };
          }
        ];
      };
      nuc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/nuc/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
    };

    # Darwin work dev config
    darwinConfigurations."FF0523" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [./hosts/mac/configuration.nix];
      specialArgs = {inherit inputs outputs;};
    };

    # Home manager config
    homeConfigurations = {
      "user@nuc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./hosts/nuc/home-manager.nix];
      };
      "nima.kalantar@FF0523" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./hosts/mac/home-manager.nix];
      };
    };

    # Deploy-rs config
    deploy.nodes = {
      nuc = {
        hostname = "nuc";
        profiles.system = {
          sshUser = "root";
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nuc;
        };
      };
      mac = {
        hostname = "FF0523";
        profiles.system = {
          sshUser = "nima.kalantar";
          user = "nima.kalantar";
          path = deploy-rs.lib.aarch64-darwin.activate.nixos self.darwinConfigurations."FF0523";
        };
      };
    };

    # This is highly advised, and will prevent many possible mistakes
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
