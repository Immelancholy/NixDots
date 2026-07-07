{ lib, pkgs, ... }: {
  boot.secureBoot.enable = true;
  boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-rt-bore-lto;
}
