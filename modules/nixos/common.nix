{
  config,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  services = {
    # SSH server
    openssh.enable = true;
    openssh.permitRootLogin = "yes";
    openssh.passwordAuthentication = false;
  };

  programs.ssh.startAgent = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";

  # Enable autoupgrade
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}
