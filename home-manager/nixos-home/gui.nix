{pkgs, ...}: {
  home.packages = with pkgs; [
    texmaker
    # study
    zotero
    obsidian
    # media
    vlc
    foliate
    # visualization
    (blender.withPackages(ps: with ps; [
      rich
      numpy
      glfw
    ]))
  ];
}
