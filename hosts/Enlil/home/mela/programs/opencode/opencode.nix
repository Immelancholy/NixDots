{
  inputs,
  pkgs,
  ...
}: {
  programs.opencode = {
    enable = true;
    package = inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default;

    agents = {
      tutor = ./agents/tutor.md;
    };

    settings = {
      default_agent = "tutor";
      agent = {
        general = {
          model = "zai-coding-plan/glm-4.7";
        };
        explore = {
          model = "zai-coding-plan/glm-4.7";
        };
      };
      model = "chutes/moonshotai/Kimi-K2-Thinking-TEE";

      plugin = [
        "@simonwjackson/opencode-direnv"
        "opencode-lmstudio@latest"
        "opencode-antigravity-auth@latest"
      ];
      
      provider = {
        google = {
          models = {
            "antigravity-gemini-3-pro" = {
              name = "Gemini 3 Pro (Antigravity)";
              limit = { context = 1048576; output = 65535; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
              variants = {
                low = { thinkingLevel = "low"; };
                high = { thinkingLevel = "high"; };
              };
            };
            "antigravity-gemini-3-flash" = {
              name = "Gemini 3 Flash (Antigravity)";
              limit = { context = 1048576; output = 65536; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
              variants = {
                minimal = { thinkingLevel = "minimal"; };
                low = { thinkingLevel = "low"; };
                medium = { thinkingLevel = "medium"; };
                high = { thinkingLevel = "high"; };
              };
            };
            "antigravity-claude-sonnet-4-5" = {
              name = "Claude Sonnet 4.5 (Antigravity)";
              limit = { context = 200000; output = 64000; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
            };
            "antigravity-claude-sonnet-4-5-thinking" = {
              name = "Claude Sonnet 4.5 Thinking (Antigravity)";
              limit = { context = 200000; output = 64000; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
              variants = {
                low = { thinkingConfig = { thinkingBudget = 8192; }; };
                max = { thinkingConfig = { thinkingBudget = 32768; }; };
              };
            };
            "antigravity-claude-opus-4-5-thinking" = {
              name = "Claude Opus 4.5 Thinking (Antigravity)";
              limit = { context = 200000; output = 64000; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
              variants = {
                low = { thinkingConfig = { thinkingBudget = 8192; }; };
                max = { thinkingConfig = { thinkingBudget = 32768; }; };
              };
            };
            "gemini-2.5-flash" = {
              name = "Gemini 2.5 Flash (Gemini CLI)";
              limit = { context = 1048576; output = 65536; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
            };
            "gemini-2.5-pro" = {
              name = "Gemini 2.5 Pro (Gemini CLI)";
              limit = { context = 1048576; output = 65536; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
            };
            "gemini-3-flash-preview" = {
              name = "Gemini 3 Flash Preview (Gemini CLI)";
              limit = { context = 1048576; output = 65536; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
            };
            "gemini-3-pro-preview" = {
              name = "Gemini 3 Pro Preview (Gemini CLI)";
              limit = { context = 1048576; output = 65535; };
              modalities = { input = [ "text" "image" "pdf" ]; output = [ "text" ]; };
            };
          };
        };
        lmstudio = {
          npm = "@ai-sdk/openai-compatible";
          name = "LM Studio (local)";
          options = {
            baseUrl = "http://192.168.1.162:1234/v1";
          };
        };
      };
      
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
