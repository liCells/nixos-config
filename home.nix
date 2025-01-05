{ config, pkgs, ... }:

{
  home.username = "tecemine";
  home.homeDirectory = "/home/tecemine";

  import = [
    ./config/main.nix
  ];

  # 设置鼠标指针大小以及字体 DPI(适用于 4K 显示器)
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  home.packages = with pkgs;[
    yazi
    fastfetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    jq
    eza

    # misc
    which
    tree

    btop
  ];

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
