{
  programs.yazi.settings = {
    opener = {
      krita = [
        {
          run = "uwsm-app -- krita %s";
          orphan = true;
          for = "unix";
          desc = "Krita";
        }
      ];
    };
    open = {
      rules = [
        {
          mime = "image/*";
          use = [
            "image"
            "krita"
            "open"
          ];
        }
        {
          url = "*.kra";
          use = [
            "krita"
            "open"
          ];
        }
        {
          url = "*";
          use = [
            "edit"
            "open"
          ];
        }
      ];
    };
  };
}
