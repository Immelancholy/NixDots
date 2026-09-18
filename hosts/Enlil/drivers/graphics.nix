{
  config,
  pkgs,
  lib,
  ...
}:
{
  hardware.nvidia = {
    enable = true;
    open = true;
    package =
      let
        base = (pkgs.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest;
      in
      base.overrideAttrs (old: {
        passthru = old.passthru // {
          open = old.passthru.open.overrideAttrs (o: {
            patches = (o.patches or [ ]) ++ [ ./nvidia-open-gpio-device-const.patch ];
          });
        };
      });
  };

  nix.settings.substituters = lib.mkAfter [ "https://cache.nixos-cuda.org" ];
  nix.settings.trusted-public-keys = lib.mkAfter [
    "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
  ];
}
