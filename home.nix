{ config, pkgs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "tecemine";
  home.homeDirectory = "/home/tecemine";

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';
  import = [
    ./config/main.nix
  ];

  # 设置鼠标指针大小以及字体 DPI(适用于 4K 显示器)
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
    yazi
    fastfetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’

    # misc
    which
    tree

    btop  # replacement of htop/nmon
  ];

  # git 相关配置
  #programs.git = {
  #  enable = true;
  #  userName = "lizz";
  #  userEmail = "lizong1204@gmail.com";
  #};

  #programs.bash = {
  #  enable = true;
  #  enableCompletion = true;
    # 在这里添加你的自定义 bashrc 内容
    #bashrcExtra = ''
    #  export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    #'';

    # 设置一些别名方便使用
    #shellAliases = {
      # k = "kubectl";
    #}
  #};

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
