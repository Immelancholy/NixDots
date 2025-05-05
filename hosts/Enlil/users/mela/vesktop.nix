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
        };
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
          dmSectionCollapsed = false;
          canCollapseDmSection = false;
          userBasedCategoryList = {
            "459733044383842304" = [
              {
                id = "bt86f0qkj1";
                name = "Relic <3";
                collapsed = false;
                color = 15277667;
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
                  "1348429108979437579"
                  "966844425181491201"
                  "939649069134008321"
                  "1144763901959999499"
                  "1248082992975319103"
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
        YoutubeAdblock = {
          enabled = true;
        };
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
}
