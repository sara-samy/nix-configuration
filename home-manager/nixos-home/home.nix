{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./zsh
    ./gui.nix
    ./gnome.nix
    ../shared/git
    ../shared/nvim
    ../shared/kitty
    ../shared/vscode
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      # search
      fd
      ripgrep
      pdfgrep
      # utils
      unzip
      xclip
      figlet
      gnumake
      hyperfine
      # media utils
      yt-dlp
      ffmpeg
      imagemagick
      pqiv
      glow
      zathura
      # cli media utils
      neofetch
      trash-cli
      asciinema
      carbon-now-cli
      # nix utils
      nil
      nurl
      alejandra
      nixfmt-rfc-style
      # latex
      ghostscript
      texlive.combined.scheme-full
      texlab
      djvu2pdf
      # fonts
      fantasque-sans-mono
      (nerdfonts.override {fonts = ["JetBrainsMono" "Mononoki" "IosevkaTerm"];})
      (google-fonts.override {fonts = ["Spectral"];})
      # git
      gh
      git-open
      difftastic
      git-filter-repo
      poetry
      # web
      hugo
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

  fonts.fontconfig.enable = true;

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
