{
  description = "My NixOS and Home Manager config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    llm-git-commit = {
      url = "github:ShamanicArts/llm-git-commit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprquickshot = {
      url = "github:Immelancholy/hyprquickshot/open-screenshot-in-satty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-relic-modules = {
      url = "github:Immelancholy/Nix-Relic-Modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    viu = {
      url = "github:viu-media/viu";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    anifetch = {
      url = "github:Notenlish/anifetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    artis = {
      url = "github:Immelancholy/artis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    inori = {
      url = "github:eshrh/inori";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zsh-256color = {
      url = "github:chrissicool/zsh-256color";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winboat = {
      url = "github:TibixDev/winboat";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      # url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz"; # uncomment line for solaar version 1.1.13
      url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
    };
    yazi.url = "github:sxyazi/yazi";
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };
    yamb = {
      url = "github:h-hg/yamb.yazi";
      flake = false;
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-easymotion = {
      url = "github:zakk4223/hyprland-easymotion";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";

      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };

    hy3 = {
      # url = "github:outfoxxed/hy3";
      url = "github:nnra6864/hy3/replace-generateVersion";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.11";

      # inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:Immelancholy/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nix-relic-modules,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    mkHost = host: system:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs outputs;};
        modules = [
          nix-relic-modules.nixosModules.default
          inputs.disko.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.nur.modules.nixos.default
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.solaar.nixosModules.default
          inputs.lsfg-vk-flake.nixosModules.default
          ./hosts/${host}
          (
            {
              config,
              lib,
              ...
            }:
              with lib; {
                config = let
                  makeHM = name: _user: let
                    user = config.users.users.${name};
                  in {
                    _module.args = {
                      inherit host user;
                    };

                    imports = [
                      ./hosts/${host}/users/${name}/home.nix
                    ];
                    home.sessionVariables = {
                      NOTES_PATH = "$HOME/Documents/Obsidian-Vault"; # path to notes folder ( for neovim )
                      PROJECTS_PATH = "$HOME/Documents/Projects"; # path to Projects folder ( for neovim )
                    };
                  };
                in {
                  home-manager.users = mapAttrs makeHM config.nix-relic.users.users;
                  networking.hostName = "${host}";
                };
              }
          )
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs outputs;};
              sharedModules = [
                nix-relic-modules.homeManagerModules.default
                inputs.nixvim.homeModules.nixvim
                inputs.spicetify-nix.homeManagerModules.default
                inputs.artis.homeManagerModules.default
                inputs.zen-browser.homeModules.beta
              ];
            };
          }
        ];
      };
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      Enlil = mkHost "Enlil" "x86_64-linux";
      Ereshkigal = mkHost "Ereshkigal" "x86_64-linux";
    };
  };
}
