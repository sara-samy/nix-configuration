{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Configure console keymap
  console.keyMap = "de";

  # Set up bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Firmware of all licenses.
  hardware.enableAllFirmware = true;

  hardware.graphics.enable = true;

  # Set up timezone
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "";
  };

  # Enable Mullvad vpn
  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
    package = pkgs.mullvad-vpn;
  };

  # Configure CUPS to print documents
  services.printing.enable = false;

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  services.pipewire = {
    enable = false;
  };

  # Set up Gnome Desktop Enviroment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.gnome-terminal.enable = false;
  services.gnome = {
    gnome-remote-desktop.enable = false;
    core-utilities.enable = false;
  };
  services.xserver.excludePackages = [ pkgs.xterm ];

  system.stateVersion = "23.11"; # Do not edit.
}
