{ pkgs, ... }: {
  # home.file.".vimrc".source = ./vimrc;
  # home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  home.file.".config/kitty/kitty.conf".source = ./kitty.conf;

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
    executable = true;
  };

  home.packages = with pkgs; [
    # alacritty
    traceroute
    bind
    busybox
    wl-clipboard

    neovim
    ripgrep
    curl
    git
    wget
    gnumake

    yazi
    btop
    ctop
    fastfetch

    jq
    eza

    zip
    xz
    unzip
    p7zip

    which
    tree

    gamescope
    nix-alien

    nix-output-monitor
  ];

  programs.git = {
    enable = true;

    settings = {
        user.name = "lizz";
        user.email = "lizong1204@gmail.com";
    };

    signing.format = null;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    '';

    shellAliases = {
      vim = "nvim";

      ls = "eza";
      l = "eza -la";
      ll = "eza -l";
      ipc = "curl cip.cc";

      # docker
      dps = "docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}'";
      dpsa = "docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}'";
      dcu = "docker compose up";
      dcud = "docker compose up -d";
      dcd = "docker compose down";
      docker-compose = "docker compose";

      nix-remove-all = "nix profile list --json | jq -r '.elements | keys[]' | while read -r profile_name; do nix profile remove \"\$profile_name\"; done";
      switch-jdk-8 = "nix profile install nixpkgs#jdk8";
      switch-jdk-23 = "nix profile install nixpkgs#zulu23";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chrome";
    TERMINAL = "kitty";
    WAYLAND_DISPLAY = "wayland-1";
  };
}
