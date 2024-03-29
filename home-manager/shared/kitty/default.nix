{ config, pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    theme = "Dracula";
    font = {
      name = "IosevkaTerm Nerd Font";
      size = 12.0;
    };
    keybindings = {
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+t" = "new_tab";
      "ctrl+w" = "close_tab";
      "ctrl+enter" = "new_window";
      "shift+ctrl+w" = "close_os_window";
    };
    extraConfig = builtins.readFile ./kitty.conf;
    shellIntegration = {
      enableZshIntegration = true;
    };
  };
}
