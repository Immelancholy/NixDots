{
  pkgs,
  inputs,
  ...
}: {
  home.file.".p10k.zsh" = {
    source = ./p10k.zsh;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza -l";
      ls = "eza";
      edit = "sudo -e";
      rmpcs = "rmpc.sh";
      ca = "cava.sh";
      fastfetch = "clear; fastfetch";
      firmware = "sudo systemctl reboot --firmware-setup";
      gc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
    };
    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
    plugins = [
      {
        name = "zsh-256color";
        src = inputs.zsh-256color;
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
    ];
    initContent =
      /*
      bash
      */
      ''
        z () {
          __zoxide_z "$@"

          if git status &>/dev/null; then
            clear
            onefetch
            GIT=1
          elif [ $GIT = 1 ]; then
            clear
            fortune | pokemonsay -p fennekin -N
            GIT=0
          fi
        }
        zi () {
          __zoxide_zi "$@"

          if git status &>/dev/null; then
            clear
            onefetch
            GIT=1
          elif [ $GIT = 1 ]; then
            clear
            fortune | pokemonsay -p fennekin -N
            GIT=0
          fi
        }
        cd () {
          builtin cd "$@" || exit

          if git status &>/dev/null; then
            clear
            onefetch
            GIT=1
          elif [ $GIT = 1 ]; then
            clear
            fortune | pokemonsay -p fennekin -N
            GIT=0
          fi
        }

        switch () {
          builtin cd "$FLAKE_PATH" || exit
          clear
          fastfetch
          git add .
          git commit -m "switch"
          sudo nixos-rebuild switch --flake .
          git add .
          git commit -m "Update Flake Lock"
          builtin cd - || exit
        }

        boot () {
          builtin cd "$FLAKE_PATH" || exit
          clear
          fastfetch
          git add .
          git commit -m "switch"
          sudo nixos-rebuild boot --flake .
          git add .
          git commit -m "Update Flake Lock"
          builtin cd - || exit
        }

        update () {
          builtin cd "$FLAKE_PATH" || exit
          clear
          fastfetch
          nix flake update --flake . --commit-lock-file
          builtin cd - || exit
        }

        nixp () {
          builtin cd "$FLAKE_PATH" || exit
          git push -u origin main
          builtin cd - || exit
        }

        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        source <(fzf --zsh)

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


        if [ "$class" = "fastfetch" ];
        then
          fastfetch --logo $HOME/Pictures/fastfetch_logos/Nakari.jpg
        else
          fortune | pokemonsay -p fennekin -N
        fi
      '';
  };
}
