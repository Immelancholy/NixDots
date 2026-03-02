{config, ...}: {
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      (callPackage ../../../pkgs/xpad.nix {})
    ];
    initrd.kernelModules = ["xpad"];
  };
}
