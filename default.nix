{ stdenv
, nodejs
, pnpm
, version
, writeText
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "stashsphere-landingpage";
  inherit version;

  src = ./.;

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
  ];

  pnpmDepsHash = "sha256-wH+ut9nefCSJS6Ae6e9Ig6jEpYreKOzTv93WY5icwxQ=";

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 2;
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
