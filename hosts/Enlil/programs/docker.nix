{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    enableOnBoot = true;
  };
  hardware.nvidia-container-toolkit.enable = true;
}
