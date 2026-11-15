{ config, ... }:
{
  # boot = {
  #   extraModulePackages = with config.boot.kernelPackages; [
  #     (callPackage ../../../pkgs/paroj-xpad.nix { })
  #   ];
  #   kernelModules = [ "paroj-xpad" ];
  #   blacklistedKernelModules = [ "xpad" ];
  # };
}
