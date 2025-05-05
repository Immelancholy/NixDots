{
  pkgs,
  lib,
  config,
  ...
}: {
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    BROWSER = "zen";
    TERMINAL = "${lib.getExe pkgs.kitty}";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
    GRIMBLAST_EDITOR = "swappy";
    MPD_HOST = "${config.services.mpd.network.listenAddress}";
    MPD_PORT = "${builtins.toString config.services.mpd.network.port}";
    NOTES_PATH = "$HOME/Documents/Obsidian-Vault"; # path to notes folder ( for neovim )
    PROJECTS_PATH = "$HOME/Documents/Projects"; # path to Projects folder ( for neovim )
  };

  systemd.user.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
    GNOME_KEYRING_CONTROL = "$XDG_RUNTIME_DIR/keyring";
  };
}
