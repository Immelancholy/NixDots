{
  programs.opencode = {
    enable = true;
    settings = {
      model = "zai-coding-plan/glm-4.7";

      mcp = {
        context7 = {
          enabled = true;
          type = "local";
          command = [
            "npx"
            "-y"
            "@upstash/context7-mcp"
          ];
        };
      };
    };
  };
}
