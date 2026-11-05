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

      "Picture" = {
        "path" = "/home/tecemine/Pictures";
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

      "Downloads" = {
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

  services.avahi = {
    enable = true;
    openFirewall = true;

    extraServiceFiles.smb = ''
      <?xml version="1.0" standalone='no'?>
      <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
      <service-group>
        <name>%h</name>
        <service>
          <type>_smb._tcp</type>
          <port>445</port>
        </service>
      </service-group>
    '';
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

}
