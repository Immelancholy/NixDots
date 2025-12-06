{
  pkgs,
  lib,
  inputs,
  ...
}: let
  associations = {
    "text/plain" = ["dev.zed.Zed.desktop"];
    "text/css" = ["dev.zed.Zed.desktop"];
    "text/csv" = ["dev.zed.Zed.desktop"];
    "text/javascript" = ["dev.zed.Zed.desktop"];
    "application/json" = ["dev.zed.Zed.desktop"];
    "application/xml" = ["dev.zed.Zed.desktop"];
    "application/x-shellscript" = ["dev.zed.Zed.desktop"];
  };
in {
  xdg.mimeApps = {
    associations.added = associations;
    defaultApplications = associations;
  };
  programs.zed-editor = {
    mutableUserTasks = lib.mkForce false;
    mutableUserSettings = lib.mkForce false;
    mutableUserKeymaps = lib.mkForce false;
    installRemoteServer = true;
    extensions = [
      "nix"
      "basher"
      "markdown-oxide"
      "rumdl"
      "git-firefly"
    ];
    extraPackages = with pkgs; [
      nixd
      bash-language-server
      markdown-oxide
      rumdl
      shfmt
      inputs.alejandra.packages.${pkgs.stdenv.hostPlatform.system}.default
      shellcheck
      tree-sitter-grammars.tree-sitter-bash
      tree-sitter-grammars.tree-sitter-nix
      tree-sitter-grammars.tree-sitter-markdown
    ];
    userSettings = {
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      base_keymap = "Emacs";
      vim_mode = true;
      terminal = {
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
              ".venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          GIT_EDITOR = "zed --wait";
          EDITOR = "zed";
        };
      };
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
        "Shell Script" = {
          language_servers = [
            "bash-language-server"
          ];
          external = {
            formatter = {
              command = "shfmt";
              arguments = [
                "--filename"
                "{buffer_path}"
                "--indent"
                "2"
              ];
            };
          };
        };
      };
    };
  };
}
