{ rustPlatform
, buildNpmPackage
, importNpmLock
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
  pname = "aster-hub";
  version = "0.1.0";
  inherit src;

  cargoRoot = "hub";
  buildAndTestSubdir = "hub";
  cargoLock.lockFile = "${src}/hub/Cargo.lock";
  doCheck = false;

  postInstall = ''
    mkdir -p $out/share/aster-hub
    cp -r ${ui} $out/share/aster-hub/dist
  '';

  meta.mainProgram = "aster-hub";
}
