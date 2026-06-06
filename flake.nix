{
  description = "My NixOS and Home Manager config.";
  inputs = {
    #Default-flakes
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    git-hooks.url = "github:cachix/git-hooks.nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Override-flakes
    nix-relic = {
      url = "git+file:/home/mela/Documents/Projects/Nix-Relic";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        zarumet.follows = "zarumet";
        stylix.follows = "stylix";
        rheayna-vim.follows = "rheayna-vim";
      };
    };
    rheayna-vim = {
      url = "git+file:/home/mela/Documents/Projects/RheaynaVim";
    };
    zarumet = {
      url = "git+file:/home/mela/Documents/Projects/zarumet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "git+file:/home/mela/Documents/Projects/stylix?ref=master+zen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Added-flakes
    agenix.url = "github:ryantm/agenix";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anifetch = {
      # url = "github:Notenlish/anifetch";
      url = "git+file:/home/mela/Documents/Projects/anifetch?ref=pre-commit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Non-flakes
    momoisay = {
      url = "github:Mon4sm/momoisay";
      flake = false;
    };
    ani-cli = {
      url = "github:pystardust/ani-cli/coolans_patches";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-relic,
      agenix,
      ...
    }:
    let
      inherit (self) inputs outputs;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkHost =
        host:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs nix-relic; };
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
              with lib;
              let
                inherit (builtins) filter;
                inherit (lib.filesystem) listFilesRecursive;
                inherit (lib.strings) hasSuffix;
                inherit (lib) elem;
                imports = [ ] ++ listFilesRecursive ./hosts/${host};
                excludes =
                  [ ] ++ listFilesRecursive ./hosts/${host}/home ++ listFilesRecursive ./hosts/${host}/secrets;
                auto_import = i: e: filter (hasSuffix ".nix") (map toString (filter (p: !(elem p e)) i));
              in
              {
                imports = auto_import imports excludes;
                config =
                  let
                    makeHM =
                      name: _user:
                      let
                        user = config.users.users.${name};
                        imports = [ ] ++ listFilesRecursive ./hosts/${host}/home/${name};
                        excludes = [ ];
                      in
                      {
                        _module.args = {
                          inherit host user;
                        };

                        imports = auto_import imports excludes;

                        home.sessionVariables = {
                          NOTES_PATH = "$HOME/Documents/Obsidian-Vault"; # path to notes folder ( for neovim )
                          PROJECTS_PATH = "$HOME/Documents/Projects"; # path to Projects folder ( for neovim )
                        };
                      };
                  in
                  {
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
                extraSpecialArgs = { inherit inputs outputs nix-relic; };
                sharedModules = [
                  nix-relic.homeManagerModules.default
                  agenix.homeManagerModules.default
                ];
              };
            }
          ];
        };
    in
    {

      formatter = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          config = self.checks.${system}.pre-commit-check.config;
          inherit (config) package configFile;
          script = ''
            ${pkgs.lib.getExe package} run --all-files --config ${configFile}
          '';
        in
        pkgs.writeShellScriptBin "pre-commit-run" script
      );

      checks = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          pre-commit-check = inputs.git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixfmt.enable = true;
            };

            package = pkgs.prek;
          };
        }
      );

      devShells = forAllSystems (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
            inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
          in
          pkgs.mkShell {
            inherit shellHook;
            buildInputs = enabledPackages;
          };
      });

      overlays = import ./overlays { inherit self; };

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs { inherit system; };
        in
        import ./pkgs { inherit self; } pkgs
      );

      nixosModules = import ./modules/nixos;

      homeModules = import ./modules/home-manager;

      nixosConfigurations = {
        Enlil = mkHost "Enlil";
        Ereshkigal = mkHost "Ereshkigal";
      };
    };
}
