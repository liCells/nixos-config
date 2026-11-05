{ pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    google-chrome
    nautilus
    hyprpolkitagent

    wayland
    gvfs
    upower

    # Desktop shell.
    waybar
    awww
    waypaper
    cliphist
    wl-clipboard
    fuzzel

    # Helpers used by ~/.local/bin scripts.
    jq
    file
    findutils

    nerd-fonts.jetbrains-mono
  ];

  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };
  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
  home.file.".config/waypaper/config.ini".source = ./waypaper/config.ini;
  home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
  home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;

  home.file."Pictures/Wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  home.file.".local/bin/wallpaper.sh" = {
    source = ./scripts/wallpaper.sh;
    executable = true;
  };
  home.file.".local/bin/clipboard.sh" = {
    source = ./scripts/clipboard.sh;
    executable = true;
  };
  home.file.".local/bin/float-center.sh" = {
    source = ./scripts/float-center.sh;
    executable = true;
  };

  home.file.".local/share/icons" = {
    source = ./cursor_theme;
    recursive = true;
    executable = true;
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.sessionVariables = {
    BROWSER = "google-chrome-stable";
    TERMINAL = "alacritty";
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
  };
}
