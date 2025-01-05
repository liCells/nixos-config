{ pkgs, ... }: {
  #wayland.windowManager.hyprland.enable = true; # enable Hyprland

  home.packages = with pkgs; [
    kitty
    wayland
    #fuzzel
    rofi
    nautilus
    swww
    #nwg-look

    brightnessctl
    wireplumber
    libgtop
    bluez
    networkmanager
    dart-sass
    wl-clipboard
    upower
    gvfs
    cliphist

    hyprpanel
  ];

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;

  home.file.".config/rofi/config.rasi".source = ./rofi.rasi;

  home.file.".local/share/icons" = {
    source = ./cursor_theme;
    recursive = true;
    executable = true;
  };

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 32;
  #  "Xft.dpi" = 192;
  #  "Xft.dpi" = 96;
  #};
}
