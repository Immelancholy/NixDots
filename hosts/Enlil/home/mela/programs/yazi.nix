{
  programs.yazi.settings = {
    opener = {
      krita = [
        {
          run = "uwsm-app -- krita %s";
          orphan = true;
          for = "unix";
        }
      ];
    };
    open = {
      rules = [
        {
          url = "*.kra";
          use = "krita";
        }
        {
          url = "*";
          use = [
            "open"
          ];
        }
      ];
    };
  };
}
