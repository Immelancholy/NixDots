{config, ...}: let
  context7-zed-dir = "${config.age.secrets.context7-zed.path}";
in {
  programs.fish = {
    shellAbbrs = {
      zedit = "zeditor . --wait";
    };
    shellInit = ''
      set -gx context7_api_key "$(cat ${context7-zed-dir})"
      set -gx EDITOR "zeditor . --wait"

    '';
  };
}
