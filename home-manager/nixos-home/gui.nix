{pkgs, ...}: {
  home.packages = with pkgs; [
    zathura
    texmaker
    # study
    zotero
    obsidian
    # media
    vlc
    foliate
    blender
  ];
}
