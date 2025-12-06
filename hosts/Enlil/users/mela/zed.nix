{
  pkgs,
  lib,
  ...
}: {
  programs.zed-editor = {
    mutableUserTasks = lib.mkForce false;
    mutableUserSettings = lib.mkForce false;
    mutableUserKeymaps = lib.mkForce false;
    installRemoteServer = true;
    extensions = [
      "nix"
      "basher"
    ];
    extraPackages = with pkgs; [
      nixd
      shellcheck
      bash-language-server
      tree-sitter-grammars.tree-sitter-bash
      shfmt
    ];
    userSettings = {
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      base_keymap = "Emacs";
      vim_mode = true;
      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
        Bash = {
          language_servers = [
            "bash-language-server"
          ];
        };
      };
      lsp = {
        bash-language-server = {
          initialization_options = {
            formatting = {
              command = [
                "shfmt"
                "--"
              ];
            };
          };
        };
        nixd = {
          initialization_options = {
            formatting = {
              command = [
                "alejandra"
                "--quiet"
                "--"
              ];
            };
          };
          settings = {
            diagnostics = {
              suppress = [
                "sema-extra-with"
              ];
            };
          };
        };
      };
    };
  };
}
