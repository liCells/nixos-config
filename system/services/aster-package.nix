{ rustPlatform
, buildNpmPackage
, importNpmLock
, bash
, src
}:

let
  ui = buildNpmPackage {
    pname = "aster-web-ui";
    version = "0.1.0";
    src = "${src}/web";
    npmDeps = importNpmLock { npmRoot = "${src}/web"; };
    npmConfigHook = importNpmLock.npmConfigHook;
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r dist/. $out/
      runHook postInstall
    '';
  };
in
rustPlatform.buildRustPackage {
  pname = "aster";
  version = "0.1.0";
  inherit src;

  cargoLock.lockFile = "${src}/Cargo.lock";
  cargoBuildFlags = [ "--bin" "aster-web" ];

  # The bash tool hardcodes /bin/bash, which NixOS does not have. A PATH lookup would fix
  # this everywhere; keeping it here confines the fix to the packaged build.
  postPatch = ''
    substituteInPlace src/tools.rs --replace '"/bin/bash"' '"${bash}/bin/bash"'
  '';

  # The Docker image ships without running the suite; keep the two build paths identical.
  doCheck = false;

  postInstall = ''
    mkdir -p $out/share/aster-web
    cp -r ${ui} $out/share/aster-web/dist
  '';

  meta.mainProgram = "aster-web";
}
