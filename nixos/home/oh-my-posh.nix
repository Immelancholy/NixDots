{
  config,
  lib,
  ...
}: let
  base = "#${config.lib.stylix.colors.base00}";
  mantle = "#${config.lib.stylix.colors.base01}";
  surface0 = "#${config.lib.stylix.colors.base02}";
  surface1 = "#${config.lib.stylix.colors.base03}";
  surface2 = "#${config.lib.stylix.colors.base04}";
  text = "#${config.lib.stylix.colors.base05}";
  rosewater = "#${config.lib.stylix.colors.base06}";
  lavender = "#${config.lib.stylix.colors.base07}";
  red = "#${config.lib.stylix.colors.base08}";
  peach = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  teal = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  mauve = "#${config.lib.stylix.colors.base0E}";
  flamingo = "#${config.lib.stylix.colors.base0F}";
in {
  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext ''
      {
        "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
        "palette": {
              "os": "#ACB0BE",
              "pink": "${surface1}",
              "lavender": "${lavender}",
              "blue":  "${blue}",
              "wight": "#FFFFFF",
              "text": "#494D64"
        },
        "blocks": [
          {
            "alignment": "left",
            "segments": [
              {
                "background": "p:blue",
                "foreground": "p:wight",
                "powerline_symbol": "\ue0b4",
                "leading_diamond": "\ue0b6",
                "style": "diamond",
                "template": "{{.Icon}} ",
                "type": "os"
              },
              {
                "background": "p:blue",
                "foreground": "p:text",
                "powerline_symbol": "\ue0b4",
                "style": "diamond",
                "template": "{{ .UserName }}@{{ .HostName }}",
                "type": "session"
              },
              {
                "background": "p:pink",
                "foreground": "p:text",
                "properties": {
                  "folder_icon": "..\ue5fe..",
                  "home_icon": "~",
                  "style": "agnoster_short"
                },
                "powerline_symbol": "\ue0b4",
                "style": "powerline",
                "template": " {{ .Path }}",
                "type": "path"
              },
              {
                "background": "p:lavender",
                "foreground": "p:text",
                "style": "powerline",
                "properties": {
                  "branch_icon": "\ue725 ",
                  "cherry_pick_icon": "\ue29b ",
                  "commit_icon": "\uf417 ",
                  "fetch_status": false,
                  "fetch_upstream_icon": false,
                  "merge_icon": "\ue727 ",
                  "no_commits_icon": "\uf0c3 ",
                  "rebase_icon": "\ue728 ",
                  "revert_icon": "\uf0e2 ",
                  "tag_icon": "\uf412 "
                },
                "powerline_symbol": "\ue0b4",
                "template": " {{ .HEAD }}",
                "type": "git"
              }
            ],
            "type": "prompt"
          }
        ],
        "final_space": true,
        "version": 3
      }
    '');
  };
}
