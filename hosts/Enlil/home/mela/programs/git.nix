{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Immelancholy";
        email = "lenalowes0@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
      diff.tool = "nvimdiff";
      merge.tool = "nvimdiff";
    };
  };
}
