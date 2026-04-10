{ pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    material-design-icons
    font-awesome

    # 思源系列字体
    source-sans # 无衬线字体，不含汉字。字族名叫 Source Sans 3 和 Source Sans Pro，以及带字重的变体，加上 Source Sans 3 VF
    source-serif # 衬线字体，不含汉字。字族名叫 Source Code Pro，以及带字重的变体
    source-han-sans # 思源黑体
    source-han-serif # 思源宋体

    jetbrains-mono
  ];
}
