{
  stdenv,
  fetchFromGithub,
  pkgs,
  ...
}:
stdenv.mkDerivation {
  pname = "wooz";
  version = "0.1.0";

  src = fetchFromGithub {
    owner = "negrel";
    repo = "wooz";
    rev = "9635978be9e8f179ffb03ab0ed4667fc1a93415e";
    hash = "";
  };
}
