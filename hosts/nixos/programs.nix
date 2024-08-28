{ pkgs, ... }:
{
  # List packages installed system-wide.
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
}
