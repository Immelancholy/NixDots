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
  python-lsp = pkgs.python3.withPackages (ps:
    with ps; [
      python-lsp-server
      python-lsp-ruff
    ]);
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
      "latex"
      "pylsp"
      "hyprlang"
      "emoji-completions"
      "rust-snippets"
      "python-snippets"
      "make"
    ];
    extraPackages = with pkgs; [
      nixd
      rust-analyzer
      hyprls
      bash-language-server
      python-lsp
      markdown-oxide
      texlab
      rumdl
      ruff
      shfmt
      inputs.alejandra.packages.${pkgs.stdenv.hostPlatform.system}.default
      shellcheck
      tree-sitter-grammars.tree-sitter-bash
      tree-sitter-grammars.tree-sitter-nix
      tree-sitter-grammars.tree-sitter-markdown
      tree-sitter-grammars.tree-sitter-latex
      tree-sitter-grammars.tree-sitter-bibtex
      tree-sitter-grammars.tree-sitter-python
      tree-sitter-grammars.tree-sitter-hyprlang
      tree-sitter-grammars.tree-sitter-rust
      tree-sitter-grammars.tree-sitter-make
    ];
    userKeymaps = [
      {
        context = "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu";
        bindings = {
          "space g h" = "editor::ToggleSelectedDiffHunks";
          "space g s" = "editor::ToggleFocus";

          "space t i" = "editor::ToggleInlayHints";

          "space u w" = "editor::ToggleSoftWrap";

          "space c z" = "workspace::ToggleCenteredLayout";

          "space m p" = "markdown::OpenPreview";
          "space m P" = "markdown::OpenPreviewToTheSide";

          "space f p" = "projects::OpenRecent";

          "space s w" = "pane::DeploySearch";

          "space a c" = "assistant::ToggleFocus";

          "g f" = "editor::OpenExcerpts";
        };
      }
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";

          "space c a" = "editor::ToggleCodeActions";
          "space ." = "editor::ToggleCodeActions";
          "space c r" = "editor::Rename";
          "space t t" = "terminal_panel::ToggleFocus";
          "g d" = "editor::GoToDefinition";
          "g D" = "editor::GoToDefinitionSplit";
          "g i" = "editor::GoToImplementation";
          "g I" = "editor::GoToImplementationSplit";
          "g t" = "editor::GoToTypeDefinition";
          "g T" = "editor::GoToTypeDefinitionSplit";
          "g r" = "editor::FindAllReferences";
          "[ d" = "editor::GoToDiagnostic";
          "] d" = "editor::GoToPreviousDiagnostic";

          "[ e" = "editor::GoToDiagnostic";
          "] e" = "editor::GoToPreviousDiagnostic";

          "s s" = "outline::Toggle";
          "s S" = "project_symbols::Toggle";

          "space x x" = "diagnostics::Deploy";

          "[ h" = "editor::GoToHunk";
          "] h" = "editor::GoToPreviousHunk";

          "shift-h" = "pane::ActivatePreviousItem";
          "shift-l" = "pane::ActivateNextItem";

          "shift-q" = "pane::CloseActiveItem";
          "ctrl-q" = "pane::CloseActiveItem";
          "space b d" = "pane::CloseActiveItem";

          "space b o" = "pane::CloseInactiveItems";

          "ctrl-s" = "workspace::Save";

          "space space" = "pane::DeploySearch";

          "space e" = "pane::RevealInProjectPanel";
        };
      }
      {
        context = "EmptyPane || SharedScreen";
        bindings = {
          "space space" = "file_finder::Toggle";

          "space f p" = "projects::OpenRecent";
        };
      }
      {
        context = "Editor && vim_mode == visual && !VimWaiting && !menu";
        bindings = {
          "g c" = "editor::ToggleComments";
        };
      }
      {
        context = "Editor && vim_mode == insert && !menu";
        bindings = {
          "j j" = "vim::NormalBefore";
          "j k" = "vim::NormalBefore";
        };
      }
      {
        context = "Editor && vim_operator == c";
        bindings = {
          "c" = "vim::CurrentLine";
          "r" = "editor::Rename";
        };
      }
      {
        context = "Editor && vim_operator == c";
        bindings = {
          "c" = "vim::CurrentLine";
          "a" = "editor::ToggleCodeActions";
        };
      }
      {
        context = "Workspace";
        bindings = {
          "space e" = "project_panel::ToggleFocus";
          "space t t" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "a" = "project_panel::NewFile";
          "A" = "project_panel::NewDirectory";
          "r" = "project_panel::Rename";
          "d" = "project_panel::Delete";
          "x" = "project_panel::Cut";
          "y" = "project_panel::Copy";
          "p" = "project_panel::Paste";
          "q" = "workspace::ToggleRightDock";
          "space e" = "workspace::ToggleRightDock";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "Dock";
        bindings = {
          "ctrl-w h" = "workspace::ActivatePaneLeft";
          "ctrl-w l" = "workspace::ActivatePaneRight";
          "ctrl-w k" = "workspace::ActivatePaneUp";
          "ctrl-w j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "EmptyPane || SharedScreen || vim_mode == normal";
        bindings = {
          "space r t" = [
            "editor::SpawnNearestTask"
            {
              "reveal" = "no_focus";
            }
          ];
        };
      }
      {
        context = "vim_mode == normal || vim_mode == visual";
        bindings = {
          "s" = [
            "vim::PushSneak"
            {}
          ];
          "S" = [
            "vim::PushSneakBackward"
            {}
          ];
        };
      }
    ];
    userSettings = {
      project_panel = {
        button = true;
        dock = "right";
        git_status = true;
      };
      outline_panel = {
        dock = "right";
      };
      collaboration_panel = {
        dock = "right";
      };
      notification_panel = {
        dock = "right";
      };
      chat_panel = {
        dock = "right";
      };
      snippet_sort_order = "top";
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      centred_layout = {
        left_padding = 0.15;
        right_padding = 0.15;
      };
      base_keymap = "VSCode";
      vim_mode = true;
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      inlay_hints = {
        enabled = true;
      };
      diagnostics = {
        inline = {
          enabled = true;
        };
      };
      terminal = {
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          GIT_EDITOR = "zeditor --wait";
          EDITOR = "zeditor --wait";
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
        Python = {
          language_servers = [
            "basedpyright"
            "ruff"
            "pylsp"
          ];
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
