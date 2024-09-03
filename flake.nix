{
  description = "Nixos config flake";

  inputs = {

    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.05"; };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-cosmic, ... }@inputs:
    let
      common-modules = name: [
        {
          nix = {
            settings = {
              experimental-features = [ "nix-command" "flakes"];
              auto-optimise-store = true;
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
            gc = {
              automatic = true;
              dates = "weekly";
            };
          };
          networking.hostName = name;
          nixpkgs.config.allowUnfree = true;
        }
        ./modules/env.nix
        ./modules/common-pkgs.nix
        ./hosts/${name}/configuration.nix
        ./hosts/${name}/hardware-configuration.nix
      ];
      mkSystem = name: cfg: nixpkgs.lib.nixosSystem {
        system = cfg.system or "x86_64-linux";
        modules = (common-modules name) ++ (cfg.modules or []);
        specialArgs = { inherit name; } // inputs;
      };
      systems = {
        homebody = {
          modules = [
            ./modules/desktop.nix
            ./modules/gnome.nix
            nixos-cosmic.nixosModules.default
          ];
        };
        bakery = {
          modules = [
            ./modules/desktop.nix
            ./modules/gnome.nix
          ];
        };
        theplug = {};
        plantation = {};
        iso = {
          modules = [
            ({ pkgs, modulesPath }: {
              imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
              systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
            })
          ];
        };
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;
    };
}
