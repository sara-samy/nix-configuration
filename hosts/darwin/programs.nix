{
  pkgs,
  username,
  ...
}:
{
  # To search by name, run: $ nix-env -qaP | grep wget
  environment = {
    systemPackages = with pkgs; [
      vim
      git
      curl
      wget
    ];
    shells = [ pkgs.zsh ];
    variables.EDITOR = "vim";
    # Add custom icons for applications
    customIcons = {
      enable = true;
      icons = [
        {
          path = "/Applications/GeoGebra.app";
          icon = ./icons/geobra.icns;
        }
        {
          path = "/Applications/Obsidian.app";
          icon = ./icons/obsidian-light.icns;
        }
        {
          path = "/Applications/KodeLife.app";
          icon = ./icons/black.icns;
        }
        {
          path = "/Applications/Zotero.app";
          icon = ./icons/zotero.png;
        }
        {
          path = "/Users/${username}/Applications/Home Manager Apps/kitty.app";
          icon = ./icons/kitty.icns;
        }
      ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae (and related files) not listed here.
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
      "Macaulay2/tap"
    ];
    # `brew install`
    brews = [
      "php"
      "M2"
      "monolith"
      "pqiv"
    ];
    # `brew install --cask`
    casks = [
      "font-hack-nerd-font"
      "miniconda"
      "xquartz"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
