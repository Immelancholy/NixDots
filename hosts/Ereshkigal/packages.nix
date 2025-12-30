{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.sshpass
  ];
}
