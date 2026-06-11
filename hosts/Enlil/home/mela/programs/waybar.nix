{ lib, pkgs, ... }:
{
  programs.waybar.settings = {
    mainBar = {
      modules-right = lib.mkForce [
        "custom/padd"
        "custom/l_end"
        "cpu"
        "temperature"
        "memory"
        "battery"
        "custom/r_end"
        "custom/l_end"
        "pulseaudio"
        "pulseaudio#mic"
        "network"
        "bluetooth"
        "custom/tailscale"
        "custom/r_end"
        "custom/l_end"
        "tray"
        "custom/update"
        "custom/r_end"
        "custom/l_end"
        "custom/power"
        "custom/r_end"
        "custom/padd"
      ];
      "custom/tailscale" = {
        format = "󰖂";
        on-click = "hyprctl dispatch 'hl.dsp.exec_cmd(\"${lib.getExe pkgs.toggle-tsui}\")'";
        on-click-right = "hyprctl dispatch 'hl.dsp.exec_cmd(\"${lib.getExe pkgs.toggle-tsui}\")'";
        tooltip = true;
        tooltip-format = "Tailscale settings";
      };
    };
  };
}
