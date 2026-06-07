{
  stdenv,
  nodejs,
  pnpm,
  version,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "stashsphere-landingpage";
  inherit version;

  src = ./.;

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
  ];

  pnpmDepsHash = "sha256-QyIQEtBSlRKrfh4aY3SvgrbjacQGlzkeBmhcGIkNFno=";

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 3;
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
