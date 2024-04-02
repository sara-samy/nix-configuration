{pkgs, ...}: {
  home.packages = with pkgs; [
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
