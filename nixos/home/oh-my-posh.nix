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
        "blocks": [
          {
            "alignment": "right",
            "segments": [
              {
                "foreground": "${text}",
                "background": "${green}",
                "leading_diamond": "\ue0b6",
                "properties": {
                  "style": "folder"
                },
                "style": "diamond",
                "template": "\ue5ff {{ .Path }}",
                "trailing_diamond": "\ue0b4",
                "type": "path"
              },
              {
                "foreground": "${text}",
                "background": "${teal}",
                "background_templates": [
                  "{{ if or (.Working.Changed) (.Staging.Changed) }}${peach}{{ end }}",
                  "{{ if and (gt .Ahead 0) (gt .Behind 0) }}${mauve}{{ end }}",
                  "{{ if gt .Ahead 0 }}${surface1}{{ end }}",
                  "{{ if gt .Behind 0 }}${surface1}{{ end }}"
                ],
                "leading_diamond": " \ue0b6",
                "properties": {
                  "branch_template": "{{ trunc 25 .Branch }}",
                  "fetch_stash_count": true,
                  "fetch_status": true,
                  "fetch_upstream_icon": true
                },
                "style": "diamond",
                "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} \uf046 {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
                "trailing_diamond": "\ue0b4",
                "type": "git"
              },
              {
                "foreground": "${text}",
                "background": "${yellow}",
                "leading_diamond": " \ue0b6",
                "properties": {
                  "fetch_version": false
                },
                "style": "diamond",
                "template": "\ue235 {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}",
                "trailing_diamond": "\ue0b4",
                "type": "python"
              },
              {
                "foreground": "${text}",
                "background": "${blue}",
                "leading_diamond": " \ue0b6",
                "properties": {
                  "fetch_version": false
                },
                "style": "diamond",
                "template": "\ue626{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}",
                "trailing_diamond": "\ue0b4",
                "type": "go"
              },
              {
                "foreground": "${text}",
                "background": "${green}",
                "leading_diamond": " \ue0b6",
                "properties": {
                  "fetch_version": false
                },
                "style": "diamond",
                "template": "\ue718{{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }}",
                "trailing_diamond": "\ue0b4",
                "type": "node"
              },
              {
                "foreground": "${text}",
                "background": "${surface2}",
                "leading_diamond": " \ue0b6",
                "properties": {
                  "fetch_version": false
                },
                "style": "diamond",
                "template": "\ue791{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}",
                "trailing_diamond": "\ue0b4",
                "type": "ruby"
              },
              {
                "foreground": "${text}",
                "background": "${surface2}",
                "leading_diamond": " \ue0b6",
                "properties": {
                  "fetch_version": false
                },
                "style": "diamond",
                "template": "\ue738{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}",
                "trailing_diamond": "\ue0b4",
                "type": "java"
              },
              {
                "foreground": "${text}",
                "background": "${mauve}",
                "leading_diamond": " \ue0b6",
                "properties": {
                  "fetch_version": false
                },
                "style": "diamond",
                "template": "\ue624{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }} ",
                "trailing_diamond": "\ue0b4",
                "type": "julia"
              },
              {
                "type": "php",
                "style": "diamond",
                "foreground": "${text}",
                "background": "${blue}",
                "leading_diamond": " \ue0b6",
                "properties": {
                  "fetch_version": false
                },
                "template": "\ue73d {{ .Full }} ",
                "trailing_diamond": "\ue0b4"
              },
              {
                "foreground": "${text}",
                "background": "${mauve}",
                "background_templates": [
                  "{{if eq \"Charging\" .State.String}}${teal}{{end}}",
                  "{{if eq \"Discharging\" .State.String}}${red}{{end}}",
                  "{{if eq \"Full\" .State.String}}${green}{{end}}"
                ],
                "leading_diamond": " \ue0b6",
                "properties": {
                  "charged_icon": " ",
                  "charging_icon": "\u21e1 ",
                  "discharging_icon": "\u21e3 "
                },
                "style": "diamond",
                "template": "{{ if not .Error }}{{ .Icon }}{{ .Percentage }}{{ end }}{{ .Error }}",
                "trailing_diamond": "\ue0b4",
                "type": "battery"
              }
            ],
            "type": "prompt"
          },
          {
            "alignment": "left",
            "newline": true,
            "segments": [
              {
                "foreground": "${text}",
                "background": "${surface1}",
                "leading_diamond": "\ue0b6",
                "properties": {
                  "style": "austin",
                  "threshold": 150
                },
                "style": "diamond",
                "template": "{{ .FormattedMs }}",
                "trailing_diamond": "\ue0b4 ",
                "type": "executiontime"
              },
              {
                "foreground": "${text}",
                "background": "${surface1}",
                "leading_diamond": "\ue0b6",
                "style": "diamond",
                "template": "{{ .UserName }} \u276f",
                "trailing_diamond": "\ue0b4",
                "type": "text"
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
