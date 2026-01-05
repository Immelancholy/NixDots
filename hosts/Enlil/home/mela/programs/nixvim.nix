{lib, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = false;
    keymaps = [
      {
        action = {
          __raw = ''
            function() require("opencode").ask("@this: ", { submit = true }) end
          '';
        };
        key = "<C-a>";
        mode = [
          "n"
          "x"
        ];
      }
      {
        action = {
          __raw = ''
            function() require("opencode").select() end
          '';
        };
        key = "<C-x>";
        mode = [
          "n"
          "x"
        ];
      }
      {
        action = {
          __raw = ''
            function() require("opencode").toggle() end
          '';
        };
        key = "<C-s>";
        mode = [
          "n"
          "t"
        ];
      }
      {
        action = {
          __raw = ''
            function() return require("opencode").operator("@this ") end
          '';
        };
        key = "go";
        mode = [
          "n"
          "x"
        ];
      }
      {
        action = {
          __raw = ''
            function() return require("opencode").operator("@this ") .. "_" end
          '';
        };
        key = "goo";
        mode = [
          "n"
        ];
      }
      {
        action = {
          __raw = ''
            function() require("opencode").command("session.half.page.up") end
          '';
        };
        key = "<S-C-u>";
        mode = [
          "n"
        ];
      }
      {
        action = {
          __raw = ''
            function() require("opencode").command("session.half.page.down") end
          '';
        };
        key = "<S-C-d>";
        mode = [
          "n"
        ];
      }
      {
        action = {
          __raw = ''
            function() require("opencode").command("session.half.page.down") end
          '';
        };
        key = "<S-C-d>";
        mode = [
          "n"
        ];
      }
    ];
    plugins = {
      opencode = {
        enable = true;
      };
      snacks = {
        enable = true;
        settings = {
          input.enabled = true;
          terminal.enabled = true;
          picker.enabled = true;
        };
      };
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
      blink-cmp-copilot = {
        enable = true;
      };
      neo-tree = {
        window.position = lib.mkForce "left";
      };
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            enabled = false;
          };
          panel = {
            enabled = false;
          };
        };
      };
      blink-cmp = {
        settings = {
          sources = {
            default = [
              "copilot"
            ];
            providers = {
              copilot = {
                async = true;
                module = "blink-cmp-copilot";
                name = "copilot";
                score_offset = 100;
              };
            };
          };
          appearance.kind_icons = {
            Copilot = "";
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
