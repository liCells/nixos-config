{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # audio control
      pavucontrol
      playerctl
      pulsemixer
      # images
      imv
    ];
    file.".config/mpv" = {
      source = ./mpv;
      recursive = true;
      executable = true;
    };
  };

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    obs-studio.enable = true;
  };

  services = {
    playerctld.enable = true;
  };

}
