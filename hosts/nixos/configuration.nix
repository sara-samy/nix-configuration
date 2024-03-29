{
  pkgs,
  username,
  hostnameNixOS,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Perform garbage collection weekly.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  # Optimize storage.
  nix.settings.auto-optimise-store = true;
  # Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "${hostnameNixOS}";
  networking.networkmanager.enable = true;
  networking.iproute2.enable = true;

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

  # Configure console keymap
  console.keyMap = "de";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "";
  };

  # Mullvad vpn
  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
    package = pkgs.mullvad-vpn;
  };

  # Configure CUPS to print documents.
  services.printing.enable = false;

  # Enable Firmware of all licenses.
  hardware.enableAllFirmware = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  services.pipewire = {
    enable = false;
  };

  # Set up Gnome Desktop Enviroment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.gnome-terminal.enable = false;
  services.gnome = {
    gnome-remote-desktop.enable = false;
    core-utilities.enable = false;
  };
  services.xserver.excludePackages = [pkgs.xterm];

  # Define a user.
  users.users.${username} = {
    isNormalUser = true;
    description = "Sara Samy";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
      gnome-console
      gnome.nautilus
      gnome.gnome-tweaks
    ];
  };
  # Enable zsh and set it as default shell for user.
  programs.zsh.enable = true;
  users.users.${username}.shell = pkgs.zsh;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "${username}";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # List packages installed system-wide.
  nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "electron-25.9.0" ];
  };
  environment = {
      gnome.excludePackages = [ pkgs.gnome-tour ];
      systemPackages = with pkgs; [
          vim
          git
          wget
          curl
      ];
      variables.EDITOR = "vim";
  };

  system.stateVersion = "23.11"; # Do not edit.
}
