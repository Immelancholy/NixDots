{pkgs, ...}: let
  zoxgit = pkgs.writeShellApplication {
    name = "zoxgit";

    runtimeInputs = with pkgs; [
      git
      onefetch
      zoxide
    ];

    text =
      /*
      bash
      */
      ''
        function fetch () {
          git_status=$(git status)

          if [ "$git_status" != "fatal: not a git repository (or any of the parent directories): .git" ]; then
            onefetch
          fi
        }
        z "$@"
        fetch
      '';
  };
in {
  environment.systemPackages = [
    zoxgit
  ];
}
