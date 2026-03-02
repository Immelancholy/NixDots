{config, ...}: {
  drivers = {
    amd.enable = false;
    intel.enable = false;
    nvidia = {
      enable = true;
      open = true;
      powerManagement = true;
      finePowerManagement = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        enable = false;
        # intelBusId = ""; # For Intel
        # amdgpuBusId = ""; # For AMD
        nvidiaBusId = "";
      };
    };
  };
}
