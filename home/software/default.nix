{ pkgs, ... }: {

  home.packages = with pkgs; [
    google-chrome

    clash-meta
    fsearch

    prismlauncher
  ];

}
