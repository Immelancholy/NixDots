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
  tree-sitter = with pkgs.tree-sitter-grammars; [
    tree-sitter-bash
    tree-sitter-nix
    tree-sitter-markdown
    tree-sitter-latex
    tree-sitter-bibtex
    tree-sitter-python
    tree-sitter-hyprlang
    tree-sitter-rust
    tree-sitter-make
    tree-sitter-cpp
    tree-sitter-toml
  ];
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
      "discord-presence"
      "toml"
      "tombi"
      "opencode"
      "mcp-server-context7"
    ];
    extraPackages = with pkgs;
      [
        nixd
        libclang
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
        tombi
        zed-discord-presence
        inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
      ]
      ++ tree-sitter;
    userKeymaps = [
      {
        context = "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu";
        bindings = {
          "ctrl-space g h" = "editor::ToggleSelectedDiffHunks";
          "ctrl-space g s" = "editor::ToggleFocus";

          "ctrl-space t i" = "editor::ToggleInlayHints";

          "ctrl-space u w" = "editor::ToggleSoftWrap";

          "ctrl-space c z" = "workspace::ToggleCenteredLayout";

          "ctrl-space m p" = "markdown::OpenPreview";
          "ctrl-space m P" = "markdown::OpenPreviewToTheSide";

          "ctrl-space f p" = "projects::OpenRecent";

          "ctrl-space s w" = "pane::DeploySearch";

          "ctrl-space a c" = "assistant::ToggleFocus";

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

          "ctrl-space c a" = "editor::ToggleCodeActions";
          "ctrl-space ." = "editor::ToggleCodeActions";
          "ctrl-space c r" = "editor::Rename";
          "ctrl-space t t" = "terminal_panel::Toggle";

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

          "ctrl-space x x" = "diagnostics::Deploy";

          "[ h" = "editor::GoToHunk";
          "] h" = "editor::GoToPreviousHunk";

          "shift-h" = "pane::ActivatePreviousItem";
          "shift-l" = "pane::ActivateNextItem";

          "shift-q" = "pane::CloseActiveItem";
          "ctrl-q" = "pane::CloseActiveItem";
          "ctrl-space b d" = "pane::CloseActiveItem";

          "ctrl-space b o" = "pane::CloseInactiveItems";

          "ctrl-s" = "workspace::Save";

          "ctrl-space space" = "pane::DeploySearch";

          "ctrl-space e" = "pane::RevealInProjectPanel";

          "Z Z" = [
            "workspace::SendKeystrokes"
            "ctrl-s ctrl-shift-w"
          ];
        };
      }
      {
        context = "EmptyPane || SharedScreen";
        bindings = {
          "ctrl-space space" = "file_finder::Toggle";

          "ctrl-space f p" = "projects::OpenRecent";

          "ctrl-space e" = "project_panel::ToggleFocus";

          "ctrl-space r" = "workspace::ToggleRightDock";

          "ctrl-space t t" = "terminal_panel::ToggleFocus";

          "ctrl-space a c" = "assistant::ToggleFocus";

          "Z Z" = [
            "workspace::SendKeystrokes"
            "ctrl-s ctrl-shift-w"
          ];
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
        };
      }
      {
        context = "AgentPanel";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "ctrl-space t t" = "terminal_panel::Toggle";
          "ctrl-space a c" = "workspace::ToggleRightDock";
          "ctrl-space e" = "project_panel::ToggleFocus";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "ctrl-space t t" = "terminal_panel::Toggle";
          "ctrl-space a c" = "assistant::ToggleFocus";
          "ctrl-space e" = "project_panel::ToggleFocus";
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
          "w" = "project_panel::Open";
          "q" = "workspace::ToggleLeftDock";
          "ctrl-space e" = "workspace::ToggleLeftDock";
          "ctrl-space a" = "assistant::ToggleFocus";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "Z Z" = [
            "workspace::SendKeystrokes"
            "ctrl-space e ctrl-s ctrl-shift-w"
          ];
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
          "ctrl-space r t" = [
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
      agent = {
        default_model = {
          provider = "Z.ai";
          model = "glm-4.7";
        };
      };
      language_models = {
        anthropic = {
          api_url = "https://api.minimax.io/anthropic";
          available_models = [
            {
              name = "MiniMax-M2.1";
              display_name = "MiniMax M2.1";
              max_tokens = 200000;
              max_output_tokens = 128000;
              max_completion_tokens = 128000;
              capabilities = {
                tools = true;
                images = false;
                parallel_tool_calls = true;
                prompt_cache_key = true;
              };
            }
            {
              name = "MiniMax-M2";
              display_name = "MiniMax M2";
              max_tokens = 200000;
              max_output_tokens = 128000;
              max_completion_tokens = 128000;
              capabilities = {
                tools = true;
                images = false;
                parallel_tool_calls = true;
                prompt_cache_key = true;
              };
            }
          ];
        };
        openai_compatible = {
          "Z.ai" = {
            api_url = "https://api.z.ai/api/coding/paas/v4";
            available_models = [
              {
                name = "glm-4.7";
                display_name = "GLM 4.7";
                max_tokens = 200000;
                max_output_tokens = 128000;
                max_completion_tokens = 128000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                };
              }
              {
                name = "glm-4.6";
                display_name = "GLM 4.6";
                max_tokens = 200000;
                max_output_tokens = 128000;
                max_completion_tokens = 128000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                };
              }
            ];
          };
        };
      };
      terminal = {
        shell = {
          program = "fish";
        };
      };
      file_types = {
        Dockerfile = [
          "Dockerfile"
          "Dockerfile.*"
        ];
        JSON = [
          "json"
          "jsonc"
          ".code-snippets"
        ];
      };
      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/CVS"
        "**/.DS_Store"
        "**/.classpath"
        "**.settings"
        "**/out"
        "**/dist"
        "**/.husky"
        "**/.turbo"
        "**/.vscode-test"
        "**/.vscode"
        "**/.next"
        "**/.storybook"
        "**/.tap"
        "**/.nyc_output"
        "**/report"
        "**/node_modules"
        "**/result"
      ];
      features = {
        edit_prediction_provider = "copilot";
      };
      file_finder = {
        modal_max_width = "medium";
      };
      relative_line_numbers = "enabled";
      tab_bar = {
        show = true;
      };
      scrollbar = {
        show = "never";
      };
      tabs = {
        show_diagnostics = "errors";
      };
      snippet_sort_order = "top";
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      centered_layout = {
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
      lsp = {
        discord_presence = {
          initialization_options = {
            git_integration = true;
          };
        };
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
            "discord_presence"
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
          formatter = {
            external = {
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
