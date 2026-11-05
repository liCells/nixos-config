{ inputs
, pkgs
, lib
, ...
}:

let
  aster = pkgs.callPackage ./aster-package.nix { src = inputs.aster; };

  # Same layout the Docker deployment used: the checkout keeps config/, state/, secrets/ and
  # workspace/ beside the source, and every one of them is git-ignored.
  dir = "/home/tecemine/Services/git/aster";
in
{
  systemd.services.aster = {
    description = "Aster - coding agent with a web UI";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      User = "tecemine";
      Group = "users";
      WorkingDirectory = "${dir}/workspace";
      ExecStart = lib.getExe aster;
      Restart = "always";
      RestartSec = 5;
      Environment = [
        "ASTER_WEB_BIND=0.0.0.0:30001"
        "ASTER_CWD=${dir}/workspace"
        "ASTER_WEB_DIST=${aster}/share/aster-web/dist"
        # A plain file keeps the password out of the unit and out of every child process.
        "ASTER_WEB_PASSWORD_FILE=${dir}/secrets/aster_password"
        "XDG_CONFIG_HOME=${dir}/config"
        "XDG_STATE_HOME=${dir}/state"
        "HOME=/home/tecemine"
        # bash: the bash tool. rg/fd: the grep and find tools. nodejs: MCP servers run via npx.
        "PATH=${
          lib.makeBinPath [
            pkgs.bash
            pkgs.ripgrep
            pkgs.fd
            pkgs.git
            pkgs.nodejs
            pkgs.coreutils
          ]
        }"
      ];
    };
  };
}
