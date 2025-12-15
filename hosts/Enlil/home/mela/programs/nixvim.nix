{
  programs.nixvim = {
    enable = true;
    defaultEditor = false;
    plugins = {
      rustaceanvim = {
        enable = true;
        settings = {
          rustanalyzerPackafe = null;
          server = {
            cmd = [
              "rust-analyzer"
            ];
            default_settings = {
              rust-analyzer = {
                check = {
                  command = "clippy";
                };
                inlayHints = {
                  lifetimeElisionHints = {
                    enable = "always";
                  };
                };
              };
            };
            standalone = false;
          };
        };
      };
      obsidian = {
        enable = true;
        settings = {
          ui.enable = false;
          legacy_commands = false;
          workspaces = [
            {
              name = "Obsidian-Vault";
              path = "/home/mela/Documents/Obsidian-Vault/";
            }
          ];
        };
      };
    };
  };
}
