{ pkgs, ... }: {
  programs.discord = {
    enable = true;
    settings = {
      DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
      SKIP_HOST_UPDATE = true;
      SKIP_MODULE_UPDATE = true;
      openH264Enabled = true;
      BACKGROUND_COLOR = "#2c2d32";
      openasar = {
        setup = true;
        noTyping = true;
      };
      offloadAdmControls = true;
      chromiumSwitches = { };
    };
    package = pkgs.discord.override {
      withVencord = true;
      withOpenASAR = true;
    };
  };
}
