# flake.nix
{
  description = "My NixOS and Home Manager config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nix-relic-modules = {
      url = "github:Immelancholy/Nix-Relic-Modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    anifetch = {
      url = "github:Immelancholy/anifetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    artis = {
      url = "github:Immelancholy/artis";
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
    catppuccin.url = "github:catppuccin/nix";
    catppuccinZen = {
      url = "github:catppuccin/zen-browser";
      flake = false;
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
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz"; # uncomment line for solaar version 1.1.13
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
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
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    swww.url = "github:LGFae/swww";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";

      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };

    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:danth/stylix";
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
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};

    # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    nixosConfigurations = {
      Enlil = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          nix-relic-modules.nixosModules.default
          inputs.disko.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.nur.modules.nixos.default
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.solaar.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          ./nixos/system
          ./hosts/Enlil
          ./hosts/hostHome.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs outputs;};
              sharedModules = [
                nix-relic-modules.homeManagerModules.default
                inputs.catppuccin.homeModules.catppuccin
                inputs.nixvim.homeManagerModules.nixvim
                inputs.spicetify-nix.homeManagerModules.default
                inputs.artis.homeManagerModules.default
                ./nixos/home
              ];
            };
          }
        ];
      };
      Ereshkigal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs nixpkgs outputs;};
        modules = [
          nix-relic-modules.nixosModules.default
          inputs.disko.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.nur.modules.nixos.default
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.solaar.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          ./nixos/system
          ./hosts/Ereshkigal
          ./hosts/hostHome.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs outputs;};
              sharedModules = [
                nix-relic-modules.homeManagerModules.default
                inputs.catppuccin.homeModules.catppuccin
                inputs.nixvim.homeManagerModules.nixvim
                inputs.spicetify-nix.homeManagerModules.default
                inputs.nix-flatpak.homeManagerModules.nix-flatpak
                inputs.artis.homeManagerModules.default
                ./nixos/home
              ];
            };
          }
        ];
      };
    };
  };
}
