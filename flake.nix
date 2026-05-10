{
  description = "My NixOS and Home Manager config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nix-relic = {
      url = "github:Immelancholy/Nix-Relic";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        zarumet.follows = "zarumet";
      };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-git-commit = {
      url = "github:ShamanicArts/llm-git-commit";
      inputs.nixpkgs.follows = "nix-relic/nixpkgs-stable";
    };
    zarumet = {
      url = "github:Immelancholy/zarumet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    RheaynaVim = {
      url = "github:Immelancholy/RheaynaVim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "nix-relic/rust-overlay";
        neovim-nightly-overlay.follows = "neovim-nightly-overlay";
      };
    };
    ani-cli = {
      url = "github:pystardust/ani-cli";
      flake = false;
    };
    momoisay = {
      url = "github:Mon4sm/momoisay";
      flake = false;
    };
    millennium.url = "github:Immelancholy/Millennium/e2c66a276e579ee73c5151b01897bf63503aa12c?dir=packages/nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    agenix.url = "github:ryantm/agenix";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-relic,
    agenix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    mkHost = host:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs nix-relic;};
        modules = [
          nix-relic.nixosModules.default
          inputs.disko.nixosModules.default
          agenix.nixosModules.default
          (
            {
              config,
              lib,
              ...
            }:
              with lib; let
                inherit (builtins) filter map toString;
                inherit (lib.filesystem) listFilesRecursive;
                inherit (lib.strings) hasSuffix;
                inherit (lib) elem;
                imports = [] ++ listFilesRecursive ./hosts/${host};
                excludes = [] ++ listFilesRecursive ./hosts/${host}/home ++ listFilesRecursive ./hosts/${host}/secrets;
                auto_import = i: e: filter (hasSuffix ".nix") (map toString (filter (p: !(elem p e)) i));
              in {
                imports = auto_import imports excludes;
                config = let
                  makeHM = name: _user: let
                    user = config.users.users.${name};
                    imports = [] ++ listFilesRecursive ./hosts/${host}/home/${name};
                    excludes = [];
                  in {
                    _module.args = {
                      inherit host user;
                    };

                    imports = auto_import imports excludes;

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
              extraSpecialArgs = {inherit inputs outputs nix-relic;};
              sharedModules = [
                nix-relic.homeManagerModules.default
                agenix.homeManagerModules.default
              ];
            };
          }
        ];
      };
  in {
    formatter = forAllSystems (system: inputs.alejandra.packages.${system}.alejandra);

    overlays = import ./overlays;

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    nixosModules = import ./modules/nixos;

    homeModules = import ./modules/home-manager;

    nixosConfigurations = {
      Enlil = mkHost "Enlil";
      Ereshkigal = mkHost "Ereshkigal";
    };
  };
}
