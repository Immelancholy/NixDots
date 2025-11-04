{
  pkgs,
  config,
  ...
}: {
  systemd.services.pull-updates = {
    description = "Pulls changes to system config";

    restartIfChanged = false;

    onSuccess = ["rebuild.service"];

    startAt = "Sun 10:00:00";

    path = [pkgs.nix pkgs.git pkgs.gh pkgs.openssh];

    script = ''
      nix flake update --option access-tokens "github.com=$(gh auth token)" --commit-lock-file

      git push

    '';

    environment = {
      SSH_AUTH_SOCK = "/run/user/1000/gcr/ssh";
    };

    serviceConfig = {
      WorkingDirectory = "${config.nix-relic.flakePath}";

      User = "mela";

      Group = "users";

      Type = "oneshot";
    };
  };

  systemd.services.rebuild = {
    description = "Rebuilds and activates system config";

    restartIfChanged = false;

    path = [pkgs.nixos-rebuild pkgs.systemd];

    script = ''
      chown -R root:root ${config.nix-relic.flakePath}

      nixos-rebuild boot --flake .#Enlil

      booted="$(readlink /run/booted-system/{initrd,kernel,kernel-modules})"

      built="$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"



      if [ "''${booted}" = "''${built}" ]; then

        nixos-rebuild switch --flake .#${config.networking.hostName}

      fi

      chown -R mela:users ${config.nix-relic.flakePath}

    '';

    serviceConfig = {
      WorkingDirectory = "${config.nix-relic.flakePath}";
      # User = "root";
      Type = "oneshot";
    };
  };
}
