{
  lib,
  stdenvNoCC,
  udevCheckHook,
  writeTextFile,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "keychron-udev-rules";
  version = "23-10-2025";

  nativeBuildInputs = [udevCheckHook];

  src = writeTextFile {
    name = "99-keychron.rules";
    text = ''
      KERNEL=="hidraw\*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    '';
  };

  dontConfigure = true;
  dontUnpack = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 $src $out/lib/udev/rules.d/99-keychron.rules
    runHook postInstall
  '';

  meta = with lib; {
    description = "Keychron Keyboard Udev Rules, fixes issues with keyboard detection on Linux";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [kruziikrel13];
  };
})
