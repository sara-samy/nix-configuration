{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    userSettings = lib.importJSON ./vscode-settings.json;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      asvetliakov.vscode-neovim
      enkia.tokyo-night
      github.github-vscode-theme
      dracula-theme.theme-dracula
      catppuccin.catppuccin-vsc
      ms-python.python
      ms-toolsai.jupyter
      james-yu.latex-workshop
      yzhang.markdown-all-in-one
      ms-vscode.cpptools-extension-pack
    ];
  };
}
