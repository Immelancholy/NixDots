{config, ...}: let
  context7-zed-dir = "${config.age.secrets.context7-zed.path}";
in {
  programs.fish.shellInit = ''
    set context7_zed_dir $(string replace -a ''\'{' ''\'' ''\'${context7-zed-dir}')
    set context7_zed_dir $(string replace -a ''\'}' ''\'' ''\'$context7_zed_dir')
    set -gx context7_api_key "$(cat $context7_zed_dir)"

  '';
}
