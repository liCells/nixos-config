{
  ...
}: {
  imports = [
    ./maintenance.nix
    ./services/samba.nix
    ./services/check-urls.nix
    ./services/aster.nix
  ];
}
