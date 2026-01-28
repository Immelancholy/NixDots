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
      merge.tool = "nvimdiff2";
    };
  };
}
