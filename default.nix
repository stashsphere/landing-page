{
  stdenv,
  nodejs,
  pnpm,
  version,
  fetchPnpmDeps,
  pnpmConfigHook,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "stashsphere-landingpage";
  inherit version;

  src = ./.;

  nativeBuildInputs = [
    nodejs
    pnpmConfigHook
    pnpm
  ];

  pnpmDepsHash = "sha256-677LSM1JQpbPIQR5+V21K8vz+Fw4w2RgVt0iuFJvasc=";

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 4;
    hash = finalAttrs.pnpmDepsHash;
  };

  buildPhase = ''
    runHook preBuild

    pnpm build

    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out
    cp -r dist $out/.
  '';
})
