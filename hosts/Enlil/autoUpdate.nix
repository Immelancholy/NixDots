{
  pkgs,
  config,
  ...
}: let
  pass = pkgs.writeShellScriptBin "pass" ''
    ${pkgs.libsecret}/bin/secret-tool lookup unique ssh-store:/home/mela/.ssh/id_ed25519
  '';
in {
  systemd.services.pull-updates = {
    description = "Pulls changes to system config";

    restartIfChanged = false;

    onSuccess = ["rebuild.service"];

    startAt = "Sun 23:20:00";

    path = [pkgs.nix pkgs.git pkgs.gh pkgs.openssh];

    script = ''
      ssh-add $HOME/.ssh/id_ed25519

      nix flake update --option access-tokens "github.com=$(gh auth token)" --commit-lock-file

      git push

    '';

    environment = {
      DISPLAY = "dummy";
      SSH_AUTH_SOCK = "/run/user/1000/gcr/ssh";
      SSH_ASKPASS = "${pass}/bin/pass";
      DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
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
