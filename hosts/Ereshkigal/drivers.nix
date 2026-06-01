{ config, ... }:
{
  drivers = {
    amd.enable = false;
    intel.enable = false;
    nvidia = {
      enable = true;
      open = false;
      powerManagement = true;
      finePowerManagement = true;
      # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      prime = {
        enable = true;
        intelBusId = "PCI:0:2:0"; # For Intel
        # amdgpuBusId = ""; # For AMD
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
