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
      enkia.tokyo-night
      asvetliakov.vscode-neovim
      ms-python.python
      ms-toolsai.jupyter
      james-yu.latex-workshop
      yzhang.markdown-all-in-one
      ms-vscode.cpptools-extension-pack
    ];
  };
}
