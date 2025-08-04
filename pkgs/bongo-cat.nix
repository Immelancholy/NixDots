{
  rustPlatform,
  fetchFromGitHub,
  pkgs,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "bongo-cat";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "mitsaucepls";
    repo = pname;
    rev = "master";
    sha256 = "sha256-4KMwrmEmT4zE3WD1pYej2Eci6vY5NZu2ZZYLYeUyGUk=";
  };

  nativeBuildInputs = [
    pkgs.pkg-config
  ];

  cargoLock.lockFile = "${src}/Cargo.lock";
}
