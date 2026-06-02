{ pkgs, lib, ... }: {
  programs.discord = {
    enable = lib.mkForce false;
    settings = {
      DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
      SKIP_HOST_UPDATE = true;
      SKIP_MODULE_UPDATE = true;
      openH264Enabled = true;
      BACKGROUND_COLOR = "#2c2d32";
      openasar = {
        setup = true;
        noTyping = false;
      };
      offloadAdmControls = true;
      chromiumSwitches = { };
    };
    package = pkgs.discord.override {
      withVencord = true;
      withOpenASAR = true;
    };
  };
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "stable";
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
        ChatInputButtonAPI = {
            enabled = true;
        };
        CommandsAPI = {
            enabled = true;
        };
        DynamicImageModalAPI = {
            enabled = false;
        };
        MemberListDecoratorsAPI = {
            enabled = true;
        };
        MessageAccessoriesAPI = {
            enabled = true;
        };
        MessageDecorationsAPI = {
            enabled = true;
        };
        MessageEventsAPI = {
            enabled = true;
        };
        MessagePopoverAPI = {
            enabled = true;
        };
        MessageUpdaterAPI = {
            enabled = true;
        };
        ServerListAPI = {
            enabled = true;
        };
        UserSettingsAPI = {
            enabled = true;
        };
        AccountPanelServerProfile = {
            enabled = false;
        };
        AlwaysAnimate = {
            enabled = false;
        };
        AlwaysExpandRoles = {
            enabled = false;
        };
        AlwaysTrust = {
            enabled = false;
        };
        AnonymiseFileNames = {
            enabled = false;
        };
        AppleMusicRichPresence = {
            enabled = false;
        };
        AutoDNDWhilePlaying = {
            enabled = false;
        };
        BetterFolders = {
            enabled = false;
        };
        BetterGifAltText = {
            enabled = false;
        };
        BetterGifPicker = {
            enabled = false;
        };
        BetterRoleContext = {
            enabled = false;
        };
        BetterRoleDot = {
            enabled = false;
        };
        BetterSessions = {
            enabled = true;
            backgroundCheck = false;
        };
        BetterSettings = {
            enabled = false;
            disableFade = true;
            organizeMenu = true;
            eagerLoad = true;
        };
        BetterUploadButton = {
            enabled = false;
        };
        BiggerStreamPreview = {
            enabled = false;
        };
        BlurNSFW = {
            enabled = false;
        };
        CallTimer = {
            enabled = true;
        };
        CharacterCounter = {
            enabled = true;
            colorEffects = true;
        };
        ClearURLs = {
            enabled = false;
        };
        ClientTheme = {
            enabled = false;
        };
        ColorSighted = {
            enabled = false;
        };
        ConsoleJanitor = {
            enabled = false;
        };
        ConsoleShortcuts = {
            enabled = false;
        };
        CopyEmojiMarkdown = {
            enabled = false;
        };
        CopyFileContents = {
            enabled = false;
        };
        CopyStickerLinks = {
            enabled = false;
        };
        CopyUserURLs = {
            enabled = false;
        };
        CrashHandler = {
            enabled = false;
        };
        CustomCommands = {
            enabled = false;
        };
        CustomIdle = {
            enabled = false;
        };
        CustomRPC = {
            enabled = false;
        };
        Dearrow = {
            enabled = false;
        };
        Decor = {
            enabled = false;
        };
        DisableCallIdle = {
            enabled = false;
        };
        DontRoundMyTimestamps = {
            enabled = false;
        };
        Experiments = {
            enabled = false;
            toolbarDevMenu = false;
        };
        ExpressionCloner = {
            enabled = false;
        };
        F8Break = {
            enabled = false;
        };
        FakeNitro = {
            enabled = false;
            enableStickerBypass = true;
            enableStreamQualityBypass = true;
            enableEmojiBypass = true;
            transformEmojis = true;
            transformStickers = true;
            transformCompoundSentence = false;
            emojiSize = 48;
            hyperLinkText = "{{NAME}}";
            useHyperLinks = true;
            disableEmbedPermissionCheck = false;
            stickerSize = 160;
        };
        FakeProfileThemes = {
            enabled = false;
            nitroFirst = true;
        };
        FavoriteEmojiFirst = {
            enabled = false;
        };
        FavoriteGifSearch = {
            enabled = false;
        };
        FixCodeblockGap = {
            enabled = false;
        };
        FixImagesQuality = {
            enabled = false;
            originalImagesInChat = false;
        };
        FixSpotifyEmbeds = {
            enabled = false;
        };
        FixYoutubeEmbeds = {
            enabled = true;
        };
        ForceOwnerCrown = {
            enabled = false;
        };
        FriendInvites = {
            enabled = false;
        };
        FriendsSince = {
            enabled = false;
        };
        FullSearchContext = {
            enabled = false;
        };
        FullUserInChatbox = {
            enabled = false;
        };
        GameActivityToggle = {
            enabled = true;
            location = "PANEL";
            oldIcon = false;
        };
        GifPaste = {
            enabled = true;
        };
        GreetStickerPicker = {
            enabled = false;
        };
        HideMedia = {
            enabled = false;
        };
        iLoveSpam = {
            enabled = false;
        };
        IgnoreActivities = {
            enabled = false;
        };
        ImageFilename = {
            enabled = true;
            showFullUrl = false;
        };
        ImageLink = {
            enabled = true;
        };
        ImageZoom = {
            enabled = true;
            saveZoomValues = true;
            invertScroll = true;
            nearestNeighbour = false;
            square = false;
            zoom = 2;
            size = 100;
            zoomSpeed = 0.5;
        };
        ImplicitRelationships = {
            enabled = false;
        };
        IrcColors = {
            enabled = false;
        };
        KeepCurrentChannel = {
            enabled = false;
        };
        LastFMRichPresence = {
            enabled = false;
        };
        LoadingQuotes = {
            enabled = false;
        };
        MemberCount = {
            enabled = false;
        };
        MentionAvatars = {
            enabled = true;
        };
        MessageClickActions = {
            enabled = false;
        };
        MessageLatency = {
            enabled = false;
        };
        MessageLinkEmbeds = {
            enabled = false;
        };
        MessageLogger = {
            enabled = true;
            collapseDeleted = false;
            deleteStyle = "text";
            ignoreBots = false;
            ignoreSelf = false;
            ignoreUsers = "";
            ignoreChannels = "";
            ignoreGuilds = "";
            logEdits = true;
            logDeletes = true;
        };
        MoreQuickReactions = {
            enabled = false;
        };
        MutualGroupDMs = {
            enabled = false;
        };
        NewGuildSettings = {
            enabled = false;
        };
        NoBlockedMessages = {
            enabled = false;
        };
        NoDevtoolsWarning = {
            enabled = false;
        };
        NoF1 = {
            enabled = false;
        };
        NoMaskedUrlPaste = {
            enabled = false;
        };
        NoMiddleClickPaste = {
            enabled = false;
        };
        NoMosaic = {
            enabled = false;
        };
        NoOnboardingDelay = {
            enabled = false;
        };
        NoPendingCount = {
            enabled = false;
        };
        NoProfileThemes = {
            enabled = false;
        };
        NoReplyMention = {
            enabled = false;
        };
        NoServerEmojis = {
            enabled = false;
        };
        NoSystemBadge = {
            enabled = false;
        };
        NoTypingAnimation = {
            enabled = false;
        };
        NoUnblockToJump = {
            enabled = false;
        };
        NotificationVolume = {
            enabled = false;
        };
        OnePingPerDM = {
            enabled = false;
        };
        oneko = {
            enabled = true;
        };
        OpenInApp = {
            enabled = true;
            spotify = true;
            steam = true;
            epic = true;
            tidal = true;
            itunes = true;
        };
        OverrideForumDefaults = {
            enabled = false;
        };
        PauseInvitesForever = {
            enabled = false;
        };
        PermissionFreeWill = {
            enabled = false;
        };
        PermissionsViewer = {
            enabled = true;
        };
        petpet = {
            enabled = true;
        };
        PictureInPicture = {
            enabled = true;
        };
        PinDMs = {
            enabled = true;
            userBasedCategoryList = {
                "459733044383842304" = [
                    {
                        id = "9c97rtbv4f5";
                        name = "Firefly <33";
                        color = "15844367";
                        collapsed = false;
                        channels = [
                            "1311503458507030580"
                            "1229552350285398036"
                            "1311504508760883261"
                        ];
                    }
                    {
                        id = "6lezdk9ykda";
                        name = "Friends";
                        color = "15277667";
                        collapsed = false;
                        channels = [
                            "1144763901959999499"
                            "1335949326643626066"
                            "567417365877358610"
                            "1506281672587350068"
                            "1381752843186339973"
                            "622097462575890443"
                            "1049029425699758141"
                            "966844425181491201"
                            "1374818600610955264"
                            "611973716716290059"
                        ];
                    }
                ];
            };
            canCollapseDmSection = false;
            pinOrder = 0;
        };
        PlainFolderIcon = {
            enabled = false;
        };
        PlatformIndicators = {
            enabled = true;
        };
        PreviewMessage = {
            enabled = false;
        };
        QuickMention = {
            enabled = true;
        };
        QuickReply = {
            enabled = true;
        };
        ReactErrorDecoder = {
            enabled = false;
        };
        ReadAllNotificationsButton = {
            enabled = true;
        };
        RelationshipNotifier = {
            enabled = false;
        };
        ReplaceGoogleSearch = {
            enabled = false;
        };
        ReplyTimestamp = {
            enabled = false;
        };
        RevealAllSpoilers = {
            enabled = false;
        };
        ReverseImageSearch = {
            enabled = true;
        };
        ReviewDB = {
            enabled = false;
        };
        RoleColorEverywhere = {
            enabled = false;
        };
        SecretRingToneEnabler = {
            enabled = false;
        };
        Summaries = {
            enabled = false;
        };
        SendTimestamps = {
            enabled = false;
        };
        ServerInfo = {
            enabled = false;
        };
        ServerListIndicators = {
            enabled = false;
        };
        ShikiCodeblocks = {
            enabled = true;
        };
        ShowAllMessageButtons = {
            enabled = false;
        };
        ShowConnections = {
            enabled = false;
        };
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
        ShowMeYourName = {
            enabled = false;
        };
        ShowTimeoutDuration = {
            enabled = false;
        };
        SilentMessageToggle = {
            enabled = false;
        };
        SilentTyping = {
            enabled = true;
            isEnabled = true;
            showIcon = true;
        };
        SortFriendRequests = {
            enabled = false;
        };
        SpotifyControls = {
            enabled = false;
            hoverControls = false;
        };
        SpotifyCrack = {
            enabled = false;
            noSpotifyAutoPause = true;
            keepSpotifyActivityOnIdle = false;
        };
        SpotifyShareCommands = {
            enabled = false;
        };
        StartupTimings = {
            enabled = false;
        };
        StickerPaste = {
            enabled = false;
        };
        StreamerModeOnStream = {
            enabled = false;
        };
        SuperReactionTweaks = {
            enabled = false;
        };
        TextReplace = {
            enabled = false;
        };
        ThemeAttributes = {
            enabled = false;
        };
        Translate = {
            enabled = false;
        };
        TypingIndicator = {
            enabled = false;
        };
        TypingTweaks = {
            enabled = false;
        };
        Unindent = {
            enabled = false;
        };
        UnlockedAvatarZoom = {
            enabled = false;
        };
        UnsuppressEmbeds = {
            enabled = false;
        };
        UserMessagesPronouns = {
            enabled = true;
        };
        UserVoiceShow = {
            enabled = true;
            showInUserProfileModal = true;
            showInMemberList = true;
            showInMessages = true;
        };
        USRBG = {
            enabled = true;
            voiceBackground = true;
            nitroFirst = true;
        };
        ValidReply = {
            enabled = false;
        };
        ValidUser = {
            enabled = false;
        };
        VoiceChatDoubleClick = {
            enabled = false;
        };
        VcNarrator = {
            enabled = false;
        };
        VencordToolbox = {
            enabled = true;
        };
        ViewIcons = {
            enabled = false;
        };
        ViewRaw = {
            enabled = false;
        };
        VoiceDownload = {
            enabled = true;
        };
        VoiceMessages = {
            enabled = true;
            echoCancellation = true;
            noiseSuppression = true;
        };
        VolumeBooster = {
            enabled = true;
            multiplier = 2;
        };
        WhoReacted = {
            enabled = true;
        };
        XSOverlay = {
            enabled = false;
        };
        YoutubeAdblock = {
            enabled = true;
        };
        BadgeAPI = {
            enabled = true;
        };
        NoTrack = {
            enabled = true;
            disableAnalytics = true;
        };
        Settings = {
            enabled = true;
            settingsLocation = "aboveNitro";
            includeVencordInfoWhenCopying = true;
        };
        ConcatenatedComponentExtractor = {
            enabled = true;
        };
        SupportHelper = {
            enabled = true;
        };
      };
    };
  };
}
