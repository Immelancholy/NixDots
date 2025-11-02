{
  description = "My NixOS and Home Manager config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nix-relic = {
      url = "github:Immelancholy/Nix-Relic/dev";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
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
