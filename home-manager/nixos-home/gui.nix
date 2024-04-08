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
    libGLU
    glxinfo
    (blender-hip.withPackages(ps: with ps; [
      rich
      numpy
      python311Packages.pyopengl
      python311Packages.glcontext
      python311Packages.pyglm
      python311Packages.pyopengl-accelerate
      glfw
    ]))
  ];
}
