{
  config,
  lib,
  ...
}:
with lib; let
  hostName = config.networking.hostName;
  makeHM = name: _user: let
    user = config.users.users.${name};
  in (
    {
      config,
      options,
      pkgs,
      ...
    }:
      recursiveUpdate {
        _module.args = {
          inherit hostName user;
        };

        imports = [
          ./${hostName}/users/${name}/home.nix
        ];
      }
  );
in {
  home-manager.users = mapAttrs makeHM config.nix-relic.users.users;
}
