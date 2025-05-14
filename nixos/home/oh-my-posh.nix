{config, ...}: let
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
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext
      /*
      json
      */
      ''

        {
          "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
          "palette": {
            "white": "${text}",
            "tan": "${teal}",
            "teal": "${surface1}",
            "plum": "${mauve}",
            "blush": "${mantle}",
            "salmon": "${surface0}",
            "sky": "${peach}",
            "teal_blue": "${flamingo}",
          },
          "transient_prompt": {
            "background": "transparent",
            "foreground": "${green}",
            "template": "~~> "
          },
          "blocks": [
            {
              "alignment": "left",
              "segments": [
                {
                  "type": "text",
                  "style": "diamond",
                  "leading_diamond": "\ue0b6",
                  "foreground": "p:white",
                  "background": "p:tan",
                  "template": "{{ if .Env.PNPPSHOST }} \uf8c5 {{ .Env.PNPPSHOST }} {{ end }}"
                },
                {
                  "type": "text",
                  "style": "powerline",
                  "foreground": "p:white",
                  "background": "p:teal",
                  "powerline_symbol": "\ue0b0",
                  "template": "{{ if .Env.PNPPSSITE }} \uf2dd {{ .Env.PNPPSSITE }}{{ end }}"
                },
                {
                  "type": "text",
                  "style": "diamond",
                  "trailing_diamond": "\ue0b4",
                  "foreground": "p:white",
                  "background": "p:teal",
                  "template": "{{ if .Env.PNPPSSITE }}\u00A0{{ end }}"
                }
              ],
              "type": "rprompt"
            },
            {
              "alignment": "left",
              "segments": [
                {
                  "background": "#0C212F",
                  "foreground": "p:white",
                  "leading_diamond": "\ue0b6",
                  "trailing_diamond": "\ue0b0",
                  "style": "diamond",
                  "template": " {{ .Icon }} ",
                  "type": "os"
                },
                {
                  "background": "p:plum",
                  "foreground": "p:white",
                  "powerline_symbol": "\ue0b0",
                  "style": "diamond",
                  "template": " {{ .UserName }} ",
                  "type": "session"
                },
                {
                  "background": "p:blush",
                  "foreground": "p:white",
                  "powerline_symbol": "\ue0b0",
                  "properties": {
                    "style": "folder"
                  },
                  "style": "powerline",
                  "template": " {{ .Path }} ",
                  "type": "path"
                },
                {
                  "background": "p:salmon",
                  "foreground": "p:white",
                  "powerline_symbol": "\ue0b0",
                  "properties": {
                    "branch_icon": "",
                    "fetch_stash_count": true,
                    "fetch_status": false,
                    "fetch_upstream_icon": true
                  },
                  "style": "powerline",
                  "template": " \u279c ({{ .UpstreamIcon }}{{ .HEAD }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }}) ",
                  "type": "git"
                },
                {
                  "background": "p:sky",
                  "foreground": "p:white",
                  "powerline_symbol": "\ue0b0",
                  "style": "powerline",
                  "template": " \ue718 {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} ",
                  "type": "node"
                },
                {
                  "background": "p:teal_blue",
                  "foreground": "p:white",
                  "properties": {
                    "time_format": "15:04"
                  },
                  "style": "diamond",
                  "template": " \u2665 {{ .CurrentDate | date .Format }} ",
                  "trailing_diamond": "\ue0b0",
                  "type": "time"
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
