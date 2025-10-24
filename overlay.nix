final: prev: {
  stashsphereLandingPageVersion = "0.1";
  stashsphereLandingPage = with final; final.callPackage ./default.nix { version=stashsphereLandingPageVersion; };
}
