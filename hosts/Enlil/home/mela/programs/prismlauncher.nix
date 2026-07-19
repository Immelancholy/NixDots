{ pkgs, ... }: {
  programs.prismlauncher = {
    enable = true;
    package = pkgs.prismlauncher.override {
      jdks = with pkgs.javaPackages.compiler; [
        temurin-bin.jdk-25
        temurin-bin.jdk-21
        temurin-bin.jdk-17
        temurin-bin.jdk-8
      ];
    };
  };
}
