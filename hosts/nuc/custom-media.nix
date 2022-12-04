{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # zfs package is broken so this is required
  nixpkgs.config.allowBroken = true;

  # compress with zstd
  isoImage.compressImage = true;

  environment.systemPackages = with pkgs; [
    git
  ];
}
