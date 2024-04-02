{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./zsh
    ../shared/git
    ../shared/nvim
    ../shared/kitty
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    packages = with pkgs; [
      fd
      unzip
      ripgrep
      pdfgrep
      # display
      figlet
      neofetch
      # nix related
      nil
      nurl
      alejandra
      # android
      android-tools
      scrcpy
      # latex
      ghostscript
      texlive.combined.scheme-full
      texlab
      # media
      yt-dlp
      ffmpeg
      imagemagick
      glow
      zathura
      # git
      gh
      difftastic
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    file = {
      "starship.toml" = {
        source = ../shared/starship.toml;
      };
      "zathurarc" = {
        source = ../shared/zathurarc;
      };
    };

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
    enableZshIntegration = true;
  };
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
    enableAliases = true;
    extraOptions = ["--icons"];
  };
  programs.bat = {
    enable = true;
    config = {
      color = "always";
      pager = "less -FR";
      theme = "ansi";
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = pkgs.lib.importTOML ../shared/starship.toml;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    historyWidgetOptions = ["--sort" "--exact"];
    fileWidgetCommand = "";
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
