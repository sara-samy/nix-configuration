{ config, lib, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = false;
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "brackets" ];
      styles = {
        comment = "fg=black, italic";
	path = "fg=#82AAFF";
      };
    };
    history = {
      save = 1000;
      size = 1000;
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
	      rev = "v0.7.0";
	      hash = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
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
          rev = "v1.1";
          hash = "sha256-5vQodWvw9akVvvmpVQH0KjdWmCP7vQz2QOK4Yn24MbA=";
        };
      }
    ];
    shellAliases = import ./aliases.nix {inherit pkgs lib config;};
    initExtra = ''
      ${builtins.readFile ./zsh-functions}
      ${builtins.readFile ./keybindings}
    '';
  };
}
