{
  pkgs,
  config,
  username,
  ...
}: {
  imports = [
    ./zsh
    ../shared/git
    ../shared/nvim
    ../shared/kitty
    ../shared/emacs
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
      cmake
      pkg-config
      trash-cli
      figlet
      hyperfine
      # media utils
      yt-dlp-light
      ffmpeg
      imagemagick
      nodejs_23 # needed for vim copilot
      # cli media utils
      glow
      zathura
      neofetch
      asciinema
      # nix utils
      nil
      nurl
      alejandra
      nixfmt-rfc-style
      nix-prefetch-github
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
      git-open
      difftastic
      git-filter-repo
      # gui, symlinks in ~/Application
      skimpdf
      keycastr
      # web
      wabt
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      DOOMDIR = "${config.xdg.configHome}/doom";
      EMACSDIR = "${config.xdg.configHome}/emacs";
      DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
      DOOMPROFILELOADFILE = "${config.xdg.stateHome}/doom-profiles-load.el";
    };

    sessionPath = [
      # for poetry, installed using `curl -sSL https://install.python-poetry.org | python3 -`
      "$HOME/.local/bin"
      # homebrew
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "/opt/homebrew/Caskroom"
      # skim for vimtex viewer
      "$HOME/Applications/Home Manager Apps/Skim.app/Contents/MacOS"
      # gui blender
      "/Applications/Blender.app/Contents/MacOS"
      # emacs
      "${config.xdg.configHome}/emacs/bin"
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
  programs.emacs= {
    enable = true;
    package = pkgs.emacs;
  };
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
    enableZshIntegration = true;
  };
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
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
    nix-direnv.enable = true;
    enableZshIntegration = true;
    config = pkgs.lib.importTOML ../shared/direnv.toml;
  };
}
