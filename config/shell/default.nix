{ pkgs, ... }: {
  home.file.".vimrc".source = ./vimrc;
  # home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;

  home.packages = with pkgs; [
    # alacritty

    vim
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
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "chrome";
    TERMINAL = "kitty";
  };
}
