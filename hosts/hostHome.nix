{config, ...}: {
  nix-relic.home-manager.config = {
    imports = [
      ./${config.networking.hostName}/users/${config.nix-relic.home-manager.config.home.username}/home.nix
    ];
  };
}
