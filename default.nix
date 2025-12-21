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

  pnpmDepsHash = "sha256-rq63uJypWq2LqGjtk97hYoObLxIslNtsEoYv3bg6d3A=";

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
