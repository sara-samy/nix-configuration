{pkgs, ...}: {
  home.sessionVariables.GTK_THEME = "palenight";

  gtk = {
    enable = true;

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };
  };
}
