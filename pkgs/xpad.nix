{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:
stdenv.mkDerivation rec {
  pname = "xpad";
  version = "0.4";

  src = fetchFromGitHub {
    owner = "Immelancholy";
    repo = pname;
    rev = "c89fcce54c802267f811ce1c0aaf3e42b1fd122b";
    hash = "sha256-oIw5Fmtoj3q8PFNlg6ABzT0Luk8lYKxnc4Tg3vnQICA=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildPhase = ''
    runHook preBuild

    make -C "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" CC=clang M="$PWD" modules

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    make -C "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" CC=clang M="$PWD" INSTALL_MOD_PATH="$out" modules_install

    runHook postInstall
  '';

  meta = with lib; {
    description = "xpad kernel module";
    homepage = "https://github.com/paroj/xpad";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
