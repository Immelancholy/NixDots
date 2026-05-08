{lib, ...}: {
  programs.fish = {
    interactiveShellInit =
      lib.mkDefault
      /*
      fish
      */
      ''
        set -U fish_greeting
        fish_vi_key_bindings
        set fish_sequence_key_delay_ms 200

        set -gx last_repo
        set -gx INIT 1

        check_tmux

        if [ "$class" = "fastfetch" ]
          fastfetch --logo 
        else
          check_for_repo
        end
      '';
  };
}
