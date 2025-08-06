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

        set -gx INIT 1
        set -gx last_repo

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

        function check_for_repo
          set -gx current_repo $(git rev-parse --show-toplevel 2> /dev/null)
          if [ "$current_repo" ] && \
            [ "$current_repo" != "$last_repo" ]
            clear
            $fetch_cmd
            set -gx last_repo $current_repo
            set -gx INIT 0
            set -gx GIT 1
          else if [ $INIT = 1 ]
            pokeget fennekin --hide-name
            set -gx GIT 0
            set -gx INIT 0
          else if [ ! "$current_repo" ] && \
            [ $GIT = 1 ]
            clear
            pokeget fennekin --hide-name
            set -gx GIT 0
            set -gx last_repo
          end
        end

        function nextd --description "Move forward in the directory history"
            set -l options h/help l/list
            argparse -n nextd --max-args=1 $options -- $argv
            or return

            if set -q _flag_help
                __fish_print_help nextd
                return 0
            end

            set -l times 1
            if set -q argv[1]
                if test $argv[1] -ge 0 2>/dev/null
                    set times $argv[1]
                else
                    printf (_ "%s: The number of positions to skip must be a non-negative integer\n") nextd >&2
                    return 1
                end
            end

            # Traverse history
            set -l code 1
            for i in (seq $times)
                # Try one step backward
                if __fish_move_last dirnext dirprev
                    # We consider it a success if we were able to do at least 1 step
                    # (low expectations are the key to happiness ;)
                    set code 0
                else
                    break
                end
            end

            # Show history if needed
            if set -q _flag_list
                dirh
            end

            # Set direction for 'cd -'
            test $code = 0
            and set -g __fish_cd_direction prev

            check_for_repo
            return $code
        end

        function prevd --description "Move back in the directory history"
            set -l options h/help l/list
            argparse -n prevd --max-args=1 $options -- $argv
            or return

            if set -q _flag_help
                __fish_print_help prevd
                return 0
            end

            set -l times 1
            if set -q argv[1]
                if test $argv[1] -ge 0 2>/dev/null
                    set times $argv[1]
                else
                    printf (_ "%s: The number of positions to skip must be a non-negative integer\n") prevd >&2
                    return 1
                end
            end

            # Traverse history
            set -l code 1
            for i in (seq $times)
                # Try one step forward
                if __fish_move_last dirprev dirnext
                    # We consider it a success if we were able to do at least 1 step
                    # (low expectations are the key to happiness ;)
                    set code 0
                else
                    break
                end
            end

            # Show history if needed
            if set -q _flag_list
                dirh
            end

            # Set direction for 'cd -'
            test $code = 0
            and set -g __fish_cd_direction next

            check_for_repo
            return $code
        end

        function z -w='z'
          __zoxide_z $argv
          check_for_repo
        end

        function zi -w='zi'
          __zoxide_zi $argv
          check_for_repo
        end

        function cd -w='cd'
          builtin cd $argv || return
          check_for_repo
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

        function nix-llm-git -w='nix-llm-git'
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          llm git-commit
          prevd || return
        end

        if [ "$class" = "fastfetch" ]
          fastfetch --logo "$HOME"/Pictures/fastfetch_logos/Nakari.jpg
        else
          check_for_repo
        end
      '';
  };
}
