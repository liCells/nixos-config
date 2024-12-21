{ pkgs, ... }: {
  #wayland.windowManager.hyprland.enable = true; # enable Hyprland

  home.packages = with pkgs; [
    kitty
    wayland
    #waybar
    #hyprpaper
    fuzzel
    nautilus
    swww

    hyprpanel
  ];

  #imports = [
  #  ./hyprpanel.nix
  #];

  home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  home.file.".config/waybar" = {
    source = ./waybar;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 32;
  #  "Xft.dpi" = 192;
  #  "Xft.dpi" = 96;
  #};
}
