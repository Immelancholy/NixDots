{
  pkgs,
  lib,
  inputs,
  ...
}: let
  associations = {
    "text/plain" = ["dev.zed.Zed-Nightly.desktop"];
    "text/css" = ["dev.zed.Zed-Nightly.desktop"];
    "text/csv" = ["dev.zed.Zed-Nightly.desktop"];
    "text/javascript" = ["dev.zed.Zed-Nightly.desktop"];
    "application/json" = ["dev.zed.Zed-Nightly.desktop"];
    "application/xml" = ["dev.zed.Zed-Nightly.desktop"];
    "application/x-shellscript" = ["dev.zed.Zed-Nightly.desktop"];
  };
in {
  xdg.mimeApps = {
    associations.added = associations;
    defaultApplications = associations;
  };
  programs.zed-editor = {
    # package = inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
      inputs.alejandra.packages.${pkgs.stdenv.hostPlatform.system}.default
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
          formatter = {
            external = {
              command = "alejandra";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
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
