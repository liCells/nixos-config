{ pkgs, ... }: {

  home.packages = with pkgs; [
    google-chrome
    spotify

    clash-meta
    fsearch

    fluent-reader

    wpsoffice

    #xorg.libX11
    #xorg.libXxf86vm
    #xorg.libXtst
    #libglvnd
    #libGL
    #zulu23
    #javaPackages.openjfx17

    jetbrains.idea-ultimate
    #jdk8
    maven

    prismlauncher
  ];

  #home.file."Code/jdks/jdk8".source = "${pkgs.jdk8}";
  #home.file."Code/jdks/jdk23".source = "${pkgs.zulu23}";

  #home.sessionVariables = {
  #  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
  #    xorg.libX11
  #    xorg.libXxf86vm
  #    xorg.libXtst
  #    libglvnd
  #    libGL
  #    zulu23
  #    javaPackages.openjfx17
  #  ]);
  #};
}
