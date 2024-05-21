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
      neofetch
      trash-cli
      asciinema
      # media utils
      yt-dlp
      ffmpeg
      imagemagick
      pqiv
      glow
      zathura
      # nix utils
      nil
      nurl
      alejandra
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
      difftastic
      git-filter-repo
      poetry
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
