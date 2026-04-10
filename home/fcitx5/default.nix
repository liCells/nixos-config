{
  pkgs,
  ...
}: {
  home.file.".local/share/fcitx5/themes" = {
    source = ./themes;
    # copy the scripts directory recursively
    recursive = true;
    # make all scripts executable
    executable = true;
  };

  xdg.configFile = {
    "fcitx5/profile" = {
      source = ./profile;
      # every time fcitx5 switch input method, it will modify ~/.config/fcitx5/profile,
      # so we need to force replace it in every rebuild to avoid file conflict.
      force = true;
    };
    "fcitx5/conf/classicui.conf".source = ./classicui.conf;
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      # for flypy chinese input method
      fcitx5-rime
      librime
      # needed enable rime using configtool after installed
      qt6Packages.fcitx5-configtool
      qt6Packages.fcitx5-chinese-addons
      fcitx5-gtk # gtk im module
    ];
  };
}
