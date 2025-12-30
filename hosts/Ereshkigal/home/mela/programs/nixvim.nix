{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      obsidian = {
        enable = true;
        settings = {
          ui.enable = false;
          legacy_commands = false;
          workspaces = [
            {
              name = "Obsidian-Vault";
              path = "/home/mela/Documents/Obsidian-Vault";
            }
          ];
        };
      };
    };
  };
}
