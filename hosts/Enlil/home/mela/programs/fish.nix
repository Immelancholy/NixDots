{config, ...}: let
  context7-zed-dir = "${config.age.secrets.context7-zed.path}";
in {
  programs.fish = {
    shellAbbrs = {
      zedit = "zeditor .";
    };
    shellInit = ''
      set -gx context7_api_key "$(cat ${context7-zed-dir})"
    '';
  };
}
