{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = lib.optional config.isoImage.compressImage [pkgs.zstd];
}
