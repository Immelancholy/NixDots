{
  lib,
  config,
}: let
  users = config.userAccounts.sudoUsers ++ config.userAccounts.users;
  forAllUsers = lib.genAttrs users;
in {
  home-manager.users = forAllUsers (user: {
    imports = [
      ./${config.networking.hostName}/users/${user}/home.nix
    ];
  });
}
