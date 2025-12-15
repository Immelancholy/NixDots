{
  description = "My NixOS and Home Manager config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nix-relic = {
      url = "github:Immelancholy/Nix-Relic";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    viu = {
      url = "github:viu-media/viu";
    };
    anifetch = {
      url = "github:Notenlish/anifetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-relic,
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
                excludes = [] ++ listFilesRecursive ./hosts/${host}/home;
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
      Enlil = mkHost "Enlil";
      Ereshkigal = mkHost "Ereshkigal";
    };
  };
}
