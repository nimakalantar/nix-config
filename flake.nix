{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

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
    flake-utils,
    home-manager,
    sops-nix,
    deploy-rs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    deploy = {
      nodes = {
        nuc = {
          hostname = "nuc";
          profiles.system = {
            sshUser = "root";
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nuc;
          };
        };
      };
    };

    # This is highly advised, and will prevent many possible mistakes
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

    formatter.x86_64-linux = pkgs.alejandra;

    # Devshell for bootstrapping
    # Acessible through 'nix develop' or 'nix-shell' (legacy)
    devShells.x86_64-linux = import ./shell.nix {inherit pkgs;};

    # Reusable nixos modules you might want to export
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      nuc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
    };

    homeConfigurations = {
      "user@nuc" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
        ];
      };
    };
  };
}
