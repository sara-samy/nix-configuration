{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = false;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["brackets"];
      styles = {
        comment = "fg=black, italic";
        path = "fg=#82AAFF";
      };
    };
    history = {
      save = 10000;
      size = 10000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1";
          hash = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
        };
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-vi-mode";
          rev = "v0.11.0";
          hash = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "v1.2.0";
          hash = "sha256-q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
        };
      }
    ];
    sessionVariables = {
      XCODES_USERNAME = "sarrasamyy@icloud.com";
    };
    shellAliases = import ./aliases.nix { inherit pkgs lib config; };
    initExtra = ''
      ${builtins.readFile ./zsh-functions}
      ${builtins.readFile ./keybindings}
    '';
  };
}
