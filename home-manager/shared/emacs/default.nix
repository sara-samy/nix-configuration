{ ... }:
let
  doom-emacs = builtins.fetchGit {
    url = "https://github.com/doomemacs/doomemacs.git";
    rev = "2bc052425ca45a41532be0648ebd976d1bd2e6c1";
  };
in
{
  # Link the doom emacs to EMACSDIR
  xdg.configFile."emacs".source = doom-emacs;

  # Link your doom configuration
  xdg.configFile."doom".source = ./doom;
}

