{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.interfaces.enp0s31f6.wakeOnLan.enable = true;

  hardware.bluetooth.enable = false;
  hardware.bluetooth.powerOnBoot = false;

  networking.hostName = "tecemine";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.enableIPv6 = true;

  time.timeZone = "Asia/Shanghai";

  environment.variables.EDITOR = "nvim";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
    openFirewall = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 3389 5201 5900 5930 6800 8484 ];
  networking.firewall.allowedUDPPorts = [ 3389 5930 6800 8484 ];
  networking.firewall.allowedTCPPortRanges = [ { from = 30000; to = 50000; } { from = 7575; to = 7577; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 30000; to = 50000; } { from = 7575; to = 7577; } ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };
  hardware.uinput.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  users.users.tecemine = {
    isNormalUser = true;
    description = "Tecemine";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" "uinput" "video" "render" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keyFiles = [
      ./ssh/auth_key
    ];
  };

  services.getty.autologinUser = "tecemine";

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      ipv6 = false;
    };
  };

  services.tailscale.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };


  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      source-han-sans
      source-han-serif
      jetbrains-mono
    ];

    fontconfig = {
      antialias = true;

      hinting = {
        enable = true;
        style = "slight";
        autohint = false;
      };

      # 串流画面不要使用 RGB 子像素抗锯齿
      subpixel.rgba = "none";

      defaultFonts = {
        sansSerif = [
          "Noto Sans"
          "Source Han Sans SC"
        ];
        serif = [
          "Noto Serif"
          "Source Han Serif SC"
        ];
        monospace = [
          "JetBrains Mono"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";


  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  system.stateVersion = "24.11";
}
