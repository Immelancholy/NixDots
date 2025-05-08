{
  pkgs,
  config,
  ...
}: let
  base = "${config.lib.stylix.colors.base00}";
  mantle = "${config.lib.stylix.colors.base01}";
  surface0 = "${config.lib.stylix.colors.base02}";
  surface1 = "${config.lib.stylix.colors.base03}";
  surface2 = "${config.lib.stylix.colors.base04}";
  text = "${config.lib.stylix.colors.base05}";
  rosewater = "${config.lib.stylix.colors.base06}";
  lavender = "${config.lib.stylix.colors.base07}";
  red = "${config.lib.stylix.colors.base08}";
  peach = "${config.lib.stylix.colors.base09}";
  yellow = "${config.lib.stylix.colors.base0A}";
  green = "${config.lib.stylix.colors.base0B}";
  teal = "${config.lib.stylix.colors.base0C}";
  blue = "${config.lib.stylix.colors.base0D}";
  mauve = "${config.lib.stylix.colors.base0E}";
  flamingo = "${config.lib.stylix.colors.base0F}";

  mpdart-color = pkgs.writeShellScriptBin "mpdart-color" ''
    config="$XDG_CONFIG_HOME/mpdart"
    colorfile="$config/colors"

    base=$(colortrans ${base} | sed -n '2p' | awk '{print $8}')
    mantle=$(colortrans ${mantle} | sed -n '2p' | awk '{print $8}')
    surface0=$(colortrans ${surface0} | sed -n '2p' | awk '{print $8}')
    surface1=$(colortrans ${surface1} | sed -n '2p' | awk '{print $8}')
    surface2=$(colortrans ${surface2} | sed -n '2p' | awk '{print $8}')
    text=$(colortrans ${text} | sed -n '2p' | awk '{print $8}')
    rosewater=$(colortrans ${rosewater} | sed -n '2p' | awk '{print $8}')
    lavender=$(colortrans ${lavender} | sed -n '2p' | awk '{print $8}')
    red=$(colortrans ${red} | sed -n '2p' | awk '{print $8}')
    peach=$(colortrans ${peach} | sed -n '2p' | awk '{print $8}')
    yellow=$(colortrans ${yellow} | sed -n '2p' | awk '{print $8}')
    teal=$(colortrans ${teal} | sed -n '2p' | awk '{print $8}')
    blue=$(colortrans ${blue} | sed -n '2p' | awk '{print $8}')
    mauve=$(colortrans ${mauve} | sed -n '2p' | awk '{print $8}')
    flamingo=$(colortrans ${flamingo} | sed -n '2p' | awk '{print $8}')

    if [ ! -d "$config" ]; then
      echo "Making mpdart config directory"
      mkdir -p "$config"
    fi

    cat >"$colorfile" <<EOF
      ''${text:11}
      ''${text:11}
      ''${text:11}
      ''${text:11}
      ''${mauve:11}
    EOF
  '';
in {
  environment.systemPackages = [
    mpdart-color
  ];
  systemd.user.services."mpdart-color" = {
    enable = true;
    name = "mpdart Color";
    wantedBy = ["default.target"];
    path = [
      "/run/current-system/sw"
    ];
    script = ''mpdart-color'';
  };
}
