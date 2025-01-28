{
  ...
}: {
  services = {
    ########################################
    # 1. Samba (SMB) 配置
    ########################################
    samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;

      settings = {
        "private" = {
          "path" = "/home/tecemine/Downloads";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "valid users" = "tecemine";
        };
      };
    };
  };

}
