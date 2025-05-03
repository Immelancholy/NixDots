{
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "canary";
      minimizeToTray = true;
      arRPC = true;
      spellCheckLanguages = [
        "en-gb"
        "en"
      ];
    };
    vencord.settings = {
      autoUpdate = true;
      autoUpdateNotification = true;
      notifications = {
        timeout = 5000;
        position = "bottom-right";
        useNative = "not-focused";
        logLimit = 50;
      };
    };
  };
}
