{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = false;
  hardware.bluetooth.powerOnBoot = false;

  networking.hostName = "tecemine";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.enableIPv6 = false;

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = true; # disable password login
    };
    openFirewall = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 3389 5201 5930 6800 8484 ];
  networking.firewall.allowedUDPPorts = [ 3389 5930 6800 8484 ];
  networking.firewall.allowedTCPPortRanges = [ { from = 30000; to = 50000; } { from = 7575; to = 7577; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 30000; to = 50000; } { from = 7575; to = 7577; } ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  users.users.tecemine = {
    isNormalUser = true;
    description = "Tecemine";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
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

  programs.hyprland.enable = true;

  system.stateVersion = "24.11";
}
