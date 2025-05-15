{
  config,
  lib,
  ...
}: {
  home-manager.users = let
    hostName = config.networking.hostName;
    users = config.nix-relic.users.users;
  in
    builtins.mapAttrs (user:
      lib.nameValuePair user {
        imports = [
          ./${hostName}/users/${user}/home.nix
        ];
      })
    users);
}
