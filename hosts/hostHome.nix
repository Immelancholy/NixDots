{config, ...}: {
  nix-relic.home-manager.config = {
    imports = [
      ./${config.networking.hostName}/users/${config.home.username}/home.nix
    ];
  };
}
