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
    ../shared/vscode
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    packages = with pkgs; [
      # search
      fd
      ripgrep
      pdfgrep
      # utils
      coreutils
      unzip
      figlet
      neofetch
      asciinema
      # media utils
      yt-dlp
      ffmpeg
      imagemagick
      glow
      zathura
      trash-cli
      # nix utils
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
      djvu2pdf
      # git
      gh
      difftastic
      git-filter-repo
      # gui, symlinks in ~/Application
      skimpdf
      # web
      hugo
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    sessionPath = [
      # for poetry, installed using `curl -sSL https://install.python-poetry.org | python3 -`
      "$HOME/.local/bin"
      # homebrew
      "/opt/homebrew/bin"
      "/opt/homebrew/Caskroom"
      # skim for vimtex viewer
      "$HOME/Applications/Home Manager Apps/Skim.app/Contents/MacOS"
    ];

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
    nix-direnv.enable = true;
  };
}
