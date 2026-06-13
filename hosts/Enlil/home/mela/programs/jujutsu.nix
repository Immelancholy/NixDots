{ pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "lenalowes0@gmail.com";
        name = "Immelancholy";
      };
    };
  };
  home.packages = [
    pkgs.lazyjj
  ];
}
