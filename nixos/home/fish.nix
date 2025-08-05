{
  programs.fish = {
    enable = true;
    generateCompletions = true;
    preferAbbrs = true;
    shellAbbrs = {
      ll = "eza -l";
      ls = "eza";
      edit = "sudo -e";
      cava = "cava.sh";
      firmware = "sudo systemctl reboot --firmware-setup";
      gc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      nv = "nvim";
    };
    interactiveShellInit =
      /*
      fish
      */
      ''
        set -U fish_greeting
        function fish_mode_prompt; end
      '';
    shellInitLast =
      /*
      fish
      */
      ''
        fish_vi_key_bindings

        set -g INIT 1

        function onefetch_img
          set image "$(find ~/Pictures/fastfetch_logos/ -name "*.jpg" -o -name "*.png" 2> /dev/null | shuf -n1)"
          if [ "$image" ]
            onefetch --image-protocol kitty -i "$image"
          else
            onefetch
          end
        end

        function check_tmux
          if [ -z $TMUX ]
            set -gx fetch_cmd onefetch_img
          else
            set -gx fetch_cmd fastfetch
          end
        end

        check_tmux

        function check_directory_for_new_repository
          set current_repository (git rev-parse --show-toplevel 2> /dev/null)
          if [ "$current_repository" ] && \
            [ "$current_repository" != "$last_repository" ]
            clear
            $fetch_cmd
            set -gx last_repository $current_repository
            set -g INIT 0
            set -g GIT 1
          else if [ $INIT = 1 ]
            pokeget fennekin --hide-name
            set -g GIT 0
            set -g INIT 0
          else if [ ! "$current_repo" ] && \
            [ $GIT = 1 ]
            clear
            pokeget fennekin --hide-name
            set -g GIT 0
            set -gx last_repo
          end
        end

        function z -w='z'
          __zoxide_z $argv
          check_directory_for_new_repository
        end

        function zi -w='zi'
          __zoxide_zi $argv
          check_directory_for_new_repository
        end

        function cd -w='cd'
          builtin cd $argv || return
          check_directory_for_new_repository
        end

        function switch-remote -w='switch-remote'
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          git add .
          nixos-rebuild switch --flake . --sudo --ask-sudo-password --target-host $argv &| nom
          git add .
          prevd || return
        end

        function boot-remote -w='boot-remote'
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          git add .
          nixos-rebuild boot --flake . --sudo --ask-sudo-password --target-host $argv &| nom
          git add .
          prevd || return
        end

        function switch-build -w='switch-build'
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          git add .
          sudo nixos-rebuild switch --flake . &| nom
          git add .
          prevd || return
        end

        function boot -w='boot'
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          git add .
          sudo nixos-rebuild boot --flake . &| nom
          git add .
          prevd || return
        end

        function update -w='update'
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          nix flake update --flake . --commit-lock-file
          prevd || return
        end

        function nixgit -w='nixgit'
          builtin cd "$FLAKE_PATH" || return
          lazygit
          prevd || return
        end

        if [ "$class" = "fastfetch" ]
          fastfetch --logo "$HOME"/Pictures/fastfetch_logos/Nakari.jpg
        else
          check_directory_for_new_repository
        end
      '';
  };
}
