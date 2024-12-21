{ ... }: {
  imports = [
    ./base
    ./fcitx5
    ./font
    ./desktop
    ./shell
    ./software
  ];

  home = {
    homeDirectory = "/home/tecemine";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
