{ config, pkgs, ... }:

let
  # 定义需要检查的 URL 和对应的 Docker 容器
  checks = [
    { url = "https://bookmark.tecemine.top"; container = "cloudflare-nix"; }
  ];

  # 生成检查 URL 并重启容器的脚本
  checkScript = pkgs.writeScript "check-urls.sh" ''
    #!/bin/sh
    ${builtins.concatStringsSep "\n" (map (check: ''
      url="${check.url}"
      container="${check.container}"
      #echo "Checking URL: $url"
      status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
      #echo "Status code for $url: $status"
      if [ "$status" -eq 1033 ] || [ "$status" -eq 530 ]; then
        #echo "Error 1033 detected on $url, restarting container $container"
        docker restart "$container"
      fi
    '') checks)}
  '';

in
{
  # 系统级服务
  systemd.services.check-urls = {
    description = "Check the URL and restart the Docker container if needed";
    path = [ pkgs.curl pkgs.docker ];
    serviceConfig = {
      ExecStart = "${checkScript}";
      # User = "your-username";  # 指定运行用户
    };
  };

  # 系统级定时器
  systemd.timers.check-urls = {
    description = "Timer for URL checking";
    timerConfig = {
      OnCalendar = "*:0/30";  # 每30分钟执行一次
      Persistent = false;      # 系统启动时是否补跑错过的任务
    };
    wantedBy = [ "timers.target" ];  # 确保系统启动时激活
  };
}
