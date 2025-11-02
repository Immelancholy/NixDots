{
  pkgs,
  config,
  ...
}: {
  systemd.services.pull-updates = {
    description = "Pulls changes to system config";
    restartIfChanged = false;
    onSuccess = ["rebuild.service"];
    startAt = "00:20";
    path = [pkgs.git pkgs.openssh];
    script = ''
      test "$(git branch --show-current)" = "main"
      git pull --ff-only
    '';
    serviceConfig = {
      WorkingDirectory = "${config.nix-relic.flakePath}";
      User = "mela";
      Type = "oneshot";
    };
  };

  systemd.services.rebuild = {
    description = "Rebuilds and activates system config";
    restartIfChanged = false;
    path = [pkgs.nixos-rebuild pkgs.systemd];
    script = ''
      nixos-rebuild boot
      booted="$(readlink /run/booted-system/{initrd,kernel,kernel-modules})"
      built="$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"

      if [ "''${booted}" = "''${built}" ]; then
        nixos-rebuild switch
      fi
    '';
    serviceConfig.Type = "oneshot";
  };
}
