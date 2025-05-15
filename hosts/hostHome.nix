{
  config,
  lib,
  ...
}:
with lib; {
  config = let
    hostName = config.networking.hostName;
    makeHM = name: _user: let
      user = config.users.users.${name};
    in {
      _module.args = {
        inherit hostName user;
      };

      imports = mkif user.isNormalUser [
        ./${hostName}/users/${name}/home.nix
      ];
    };
  in {
    home-manager.users = mapAttrs makeHM config.nix-relic.users.users;
  };
}
