{ pkgs, ... }: {

  home.packages = with pkgs; [
    clash-meta
    google-chrome
    spotify
    fluent-reader
    wpsoffice
  ];
}
