{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        enable_posix_regex = true;
        frame_color = "#cba6f7c0";
        separator_color = "frame";
        gap_size = 3;
        highlight = "#89b4fac0";
        frame_width = 2;
        corner_radius = 15;
        origin = "top-right";
        offset = "(54, 18)";
        alignment = "center";
        icon_corner_radius = 15;
        icon_position = "top";
        max_icon_size = 256;
        font = "JetBrainsMono Nerd Font Mono 9";
      };
      urgency_low = {
        background = "#1e1e2e99";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2e99";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e99";
        foreground = "#cdd6f4";
        frame_color = "#fab387c0";
      };
    };
  };
}
