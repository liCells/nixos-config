{ pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    material-design-icons
    font-awesome

    # 思源系列字体
    source-sans
    source-serif
    source-han-sans
    source-han-serif

    jetbrains-mono
  ];
}
