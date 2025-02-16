{ pkgs, ... }: {
  home.file.".vimrc".source = ./vimrc;
  # home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  home.file.".config/kitty/kitty.conf".source = ./kitty.conf;

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
    executable = true;
  };

  home.packages = with pkgs; [
    # alacritty

    vim
    neovim
    curl
    git
    wget

    yazi
    btop
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
    userName = "lizz";
    userEmail = "lizong1204@gmail.com";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "exa";
      l = "exa -la";
      ll = "exa -l";
      ipc = "curl cip.cc";

      # docker
      dps = "docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}'";
      dpsa = "docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}'";
      dcu = "docker compose up";
      dcud = "docker compose up -d";
      dcd = "docker compose down";

      nix-remove-all = "nix profile list --json | jq -r '.elements | keys[]' | while read -r profile_name; do nix profile remove \"\$profile_name\"; done";
      switch-jdk-8 = "nix profile install nixpkgs#jdk8";
      switch-jdk-23 = "nix profile install nixpkgs#zulu23";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chrome";
    TERMINAL = "kitty";
  };
}
