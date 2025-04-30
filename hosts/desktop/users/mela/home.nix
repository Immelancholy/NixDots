{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.mela = {
    catppuccin = {
      flavor = "mocha";
      accent = "mauve";
    };
    stylix.targets = {
      # tmux.enable = false;
      # yazi.enable = false;
      # btop.enable = false;
      # spicetify.enable = false;
      # kitty.enable = false;
      # nixvim.enable = false;
      # zen.enable = false;
      # vesktop.enable = false;
    };
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
        plugins = {
          ChatInputButtonAPI.enabled = true;
          CommandsAPI.enabled = true;
          DynamicImageModelAPI.enabled = true;
          MemberListDecoratorsAPI.enabled = true;
          MessageAccessoriesAPI.enabled = true;
          MessageDecorationsAPI.enabled = true;
          MessageEventsAPI.enabled = true;
          MessagePopoverAPI.enabled = true;
          MessageUpdaterAPI.enable = true;
          ServerListAPI.enabled = true;
          UserSettingsAPI.enabled = true;
          AccountPanelServerProfile.enabled = true;
          BANger.enabled = true;
          BetterGifAltText.enabled = true;
          BetterGifPicker.enabled = true;
          BetterSessions.enabled = true;
          BetterSettings = {
            enabled = true;
            disableFade = true;
            eagerLoad = true;
          };
          BetterUploadButton.enabled = true;
          BiggerStreamPreview.enabled = true;
          BlurNSFW = {
            enabled = true;
            burAmount = 10;
          };
          CallTimer = {
            enabled = true;
            format = "stopwatch";
          };
          ClearURLs.enabled = true;
          CopyEmojiMarkdown.enabled = true;
          CrashHandler.enabled = true;
          DisableCallIdle.enabled = true;
          Experiments.enabled = true;
          FakeNitro = {
            enabled = true;
            enableStickerBypass = true;
            enableStreamQualityBypass = true;
            transformEmojis = true;
            transformStickers = true;
            stickerSize = 160;
            hyperLinkText = "{{NAME}}";
            useHyperLinks = true;
          };
          FixCodeblockGap.enabled = true;
          FixImagesQuality.enabled = true;
          FixSpotifyEmbeds.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          ForceOwnerCrown.enabled = true;
          FriendsSince.enabled = true;
          GameActivityToggle.enabled = true;
          GifPaste.enabled = true;
          GreetStickerPicker.enabled = true;
          ImageLink.enabled = true;
          ImageZoom = {
            enabled = true;
            size = 100;
            zoom = 2;
            saveZoomValues = true;
            zoomSpeed = 0.5;
          };
          MessageClickActions = {
            enabled = true;
            enableDoubleClickToEdit = true;
          };
          MessageLogger = {
            enabled = true;
            deleteStyle = "text";
            ignoreUsers = "";
            ignoreChannels = "";
            ignoreGuilds = "";
            logEdits = true;
            logDeletes = true;
            inlineEdits = true;
            MoreCommands.enabled = true;
            MoreKaomoji.enabled = true;
            Moyai = {
              enabled = true;
              ignoreBots = true;
              ignoreBlocked = true;
            };
            MutualGroupDMs.enabled = true;
            NewGuildSettings = {
              enabled = true;
              guild = true;
              everyone = true;
              role = true;
              events = true;
              highlights = true;
              messages = 3;
              showAllChannels = true;
            };
            NoOnboardingDelay.enabled = true;
            oneko.enabled = true;
            OpenInApp = {
              enabled = true;
              spotify = true;
              steam = true;
              epic = true;
              tidal = true;
              itunes = true;
            };
            PermissionsViewer.enabled = true;
            petpet.enabled = true;
            PictureInPicture.enabled = true;
            PinDMs = {
              enabled = true;
              pinOrder = 0;
              userBasedCatagoryList = {
                "459733044383842304" = [
                  {
                    id = "bt86f0qkj1";
                    name = "Relic <3";
                    color = 15277667;
                    collapsed = false;
                    channels = [
                      "1229552350285398036"
                      "1311503458507030580"
                      "1311504508760883261"
                    ];
                  }
                  {
                    id = "9e8eg7k1rze";
                    name = "Fwiends";
                    color = 15844367;
                    collapsed = false;
                    channels = [
                      "1333513114162827395"
                      "1282476722477994048"
                      "1307428447726993449"
                      "962542188993073222"
                      "567417365877358610"
                      "1300372337467850814"
                      "1245835256301486201"
                      "611973716716290059"
                      "622097462575890443"
                      "1225609280783253548"
                      "1210063490501443635"
                      "1335949326643626066"
                      "1335943073053675540"
                      "1337559345633689681"
                      "1076265681848373258"
                    ];
                  }
                ];
              };
            };
            PlatformIndicators = {
              enabled = true;
              colorMobileIndicator = true;
              list = true;
              badges = true;
              messages = true;
            };
            QuickMention.enabled = true;
            ReadAllNotificationsButton.enabled = true;
            ReplaceGoogleSearch = {
              enabled = true;
              customEngineName = "DuckDuckGo";
              customEngineURL = "https://duckduckgo.com/";
            };
            ReverseImageSearch.enabled = true;
            Summaries = {
              enabled = true;
              summaryExpiryThresholdDays = 3;
            };
            ShikiCodeblocks = {
              enabled = true;
              useDevIcon = "GREYSCALE";
              theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/2d87559c7601a928b9f7e0f0dda243d2fb6d4499/packages/tm-themes/themes/dark-plus.json";
            };
            ShowConnections.enabled = true;
            ShowHiddenChannels = {
              enabled = true;
              showMode = 0;
              hideUnreads = true;
            };
            ShowHiddenThings = {
              enabled = true;
              showTimeouts = true;
              showInvitesPaused = true;
              showModView = true;
            };
            SilentTyping = {
              enabled = true;
              isEnabled = true;
              showIcon = false;
              contextMenu = true;
            };
            SpotifyControls.enabled = true;
            SpotifyCrack = {
              enabled = true;
              noSpotifyAutoPause = true;
            };
            SpotifyShareCommands.enabled = true;
            ThemeAttributes.enabled = true;
            TypingIndicator = {
              enabled = true;
              includeMutedChannels = false;
              includeCurrentChannel = true;
              indicatorMode = 3;
            };
            TypingTweaks = {
              enabled = true;
              alternativeFormatting = true;
              showRoleColors = true;
              showAvatars = true;
            };
            UserMessagePronouns = {
              enabled = true;
              showSelf = true;
              pronounsFormat = "LOWERCASE";
            };
            ValidReply.enabled = true;
            ValidUser.enabled = true;
            VencordToolbox.enabled = true;
            VoiceDownload.enabled = true;
            VoiceMessages.enabled = true;
            VolumeBooster = {
              enabled = true;
              multiplier = 2;
            };
            WebKeybinds.enabled = true;
            WebScreenShareFixes.enabled = true;
            WhoReacted.enabled = true;
            YoutubeAdblock.enabled = true;
            NoTrack = {
              enabled = true;
              disableAnalytics = true;
            };
            WebContextMenus = {
              enabled = true;
              addBack = true;
            };
            Settings = {
              enabled = true;
              settingsLocation = "aboveNitro";
            };
            SupportHelper.enabled = true;
            BadgeAPI.enabled = true;
            DisableDeepLinks.enabled = true;
          };
        };
      };
    };
    programs.obs-studio.enable = true;
    programs.git = {
      enable = true;
      userName = "Immelancholy";
      userEmail = "lenalowes0@gmail.com";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
    services.mpd = {
      extraConfig = ''
        audio_output {
          type  "pipewire"
          name  "Pipewire Sound Server"
          target  "easyeffects_sink"
        }
      '';
    };
    wayland.windowManager.hyprland = {
      # ONLY ENABLE 1 LAYOUT!!
      layout = {
        master.enable = false;
        dwindle.enable = false;
        hy3.enable = true;
      };
      useHyprspace = false;
      liveWallpaper = {
        enable = true;
        path = ../../../../nixos/home/backgrounds/Evil_Miku.mp4;
      };
      settings = {
        cursor = {
          no_hardware_cursors = false;
        };
        monitor = "HDMI-A-1, 1920x1080@144, 0x0, 1, bitdepth, 8";
        input = {
          kb_layout = "gb";
          follow_mouse = "1";

          sensitivity = "0";
          force_no_accel = "1";
          numlock_by_default = "true";
        };
        bind = [
          "$mod, F9, pass, class:^(com.obsproject.Studio)$"
          "$mod, F10, pass, class:^(com.obsproject.Studio)$"
          "$mod, F12, pass, class:^(com.obsproject.Studio)$"
        ];
      };
    };
    home.packages = with pkgs; [
      (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {extensions = ["rust-src" "rust-analyzer"];}))
      reaper
      inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
      temurin-bin
      bespokesynth
      reaper-sws-extension
      teams-for-linux
      shotcut
      krita
      qbittorrent
      rustlings
      obsidian
      obsidian-export
      gimp3-with-plugins
      inkscape-with-extensions
      pinta
    ];
    services.remmina = {
      enable = true;
    };
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      plugins = {
        rustaceanvim = {
          enable = true;
          settings = {
            rustanalyzerPackafe = null;
            server = {
              cmd = [
                "rust-analyzer"
              ];
              default_settings = {
                rust-analyzer = {
                  check = {
                    command = "clippy";
                  };
                  inlayHints = {
                    lifetimeElisionHints = {
                      enable = "always";
                    };
                  };
                };
              };
              standalone = false;
            };
          };
        };
        obsidian = {
          enable = true;
          settings = {
            ui.enable = false;
            workspaces = [
              {
                name = "Obsidian-Vault";
                path = "/home/mela/Documents/Obsidian-Vault/";
              }
            ];
          };
        };
      };
    };
    dconf.settings = {
      "com/github/wwmm/easyeffects" = {
        last-loaded-input-preset = "Rode NT1";
        last-loaded-output-preset = "ATH-R70x";
        process-all-outputs = false;
      };
      "com/github/wwmm/easyeffects/streaminputs" = {
        input-device = "dummy_plug_out";
        use-default-input-device = false;
      };
      "com/github/wwmm/easyeffects/streamoutputs" = {
        blocklist = ["Zen"];
        output-device = "alsa_output.usb-Audient_Audient_iD4-00.pro-output-0";
        use-default-output-device = false;
      };
    };
  };
}
