{pkgs, ...}: let
  zoxgit = pkgs.writeShellApplication {
    name = "zoxgit";

    runtimeInputs = with pkgs; [
      git
      onefetch
    ];

    text =
      /*
      bash
      */
      ''
        function main () {
          z "$@"
          git_status=$(git status)

          if [ $git_status != "fatal: not a git repository (or any of the parent directories): .git" ]; then
            onefetch
          fi
        }
        main
      '';
  };
in {
  environment.systemPackages = [
    zoxgit
  ];
}
