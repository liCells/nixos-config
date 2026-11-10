{ pkgs, ... }: {
  # home.file.".vimrc".source = ./vimrc;
  home.file.".config/kitty/kitty.conf".source = ./kitty.conf;

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
    executable = true;
  };

  home.packages = with pkgs; [
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

    # 通用命令行：agent 的 bash 和日常都直接用，不必每次找 store 路径。
    # cargo/rustc 留在 nix-shell 里，版本要跟随项目。
    nodejs
    pnpm
    python3
    sqlite

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

    witr
    quickemu
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
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec uwsm start hyprland-uwsm.desktop
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
      dc = "docker compose";
      dcu = "docker compose up";
      dcud = "docker compose up -d";
      dcd = "docker compose down";
      dcr = "docker compose restart";

      nix-remove-all = "nix profile list --json | jq -r '.elements | keys[]' | while read -r profile_name; do nix profile remove \"\$profile_name\"; done";
      switch-jdk-8 = "nix profile install nixpkgs#jdk8";
      switch-jdk-23 = "nix profile install nixpkgs#zulu23";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
