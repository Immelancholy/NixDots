{
  boot.kernelModules = [
    "kvm-amd"
  ];

  virtualisation.xen = {
    enable = false;
    boot = {
      builderVerbosity = "info";
    };
  };
}
