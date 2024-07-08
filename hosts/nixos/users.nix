{
  pkgs,
  username,
  hostnameNixOS,
  ...
}: {
  # Enable zsh
  programs.zsh.enable = true;

  # Define a user
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Sara Samy";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
      gnome-console
      nautilus
      gnome-tweaks
    ];
  };

  # Enable automatic login for the user
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${username}";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Set up networking
  networking.hostName = "${hostnameNixOS}";
  networking.networkmanager.enable = true;
  networking.iproute2.enable = true;
}
