{ pkgs, ... }:

let
  checks = [
    { url = "https://bookmark.tecemine.top"; container = "cloudflare-nix"; }
  ];

  checkScript = pkgs.writeScript "check-urls.sh" ''
    #!/bin/sh
    ${builtins.concatStringsSep "\n" (map (check: ''
      url="${check.url}"
      container="${check.container}"
      status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
      if [ "$status" -eq 1033 ] || [ "$status" -eq 530 ]; then
        docker restart "$container"
      fi
    '') checks)}
  '';
in {
  systemd.services.check-urls = {
    description = "Check the URL and restart the Docker container if needed";
    path = [ pkgs.curl pkgs.docker ];
    serviceConfig = {
      ExecStart = "${checkScript}";
    };
  };

  systemd.timers.check-urls = {
    description = "Timer for URL checking";
    timerConfig = {
      OnCalendar = "*:0/30";
      Persistent = false;
    };
    wantedBy = [ "timers.target" ];
  };
}
