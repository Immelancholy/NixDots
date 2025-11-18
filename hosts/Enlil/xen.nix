{
  boot.kernelModules = [
    "kvm-amd"
  ];

  virtualisation.xen = {
    enable = true;
    boot = {
      builderVerbosity = "info";
    };
  };
}
