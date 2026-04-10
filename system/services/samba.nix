{
  ...
}: {
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        "security" = "user";
      };

      "Movies" = {
        "path" = "/home/tecemine/Movies";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "valid users" = "tecemine";
      };

      "Music" = {
        "path" = "/home/tecemine/Music";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "valid users" = "tecemine";
      };
    };
  };
}
