{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-gtk
      qt6Packages.fcitx5-configtool
    ];
  };

  xdg.configFile."fcitx5/profile" = {
    source = ./profile;
    force = true;
  };

  # Home Manager starts Fcitx5 as a user service. Hide the package's XDG
  # autostart entry so UWSM does not launch a second instance.
  xdg.configFile."autostart/org.fcitx.Fcitx5.desktop".text = ''
    [Desktop Entry]
    Hidden=true
  '';

  xdg.dataFile."fcitx5/rime/default.custom.yaml".text = ''
    patch:
      schema_list:
        - schema: double_pinyin_flypy
      menu/page_size: 9
  '';
}
