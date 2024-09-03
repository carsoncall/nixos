{
  description = "Nixos config flake";

  inputs = {

    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.05"; };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      pkgs = import nixpkgs {
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "electron-25.9.0" ];
        };
      };
      pkgs-unstable = import nixpkgs {
        config = {
          allowUnfree = true;
        };
      };
      common-modules = name: [
        {
          nix.settings.experimental-features = [ "nix-command" "flakes"];
          networking.hostName = name;
        }
        ./modules/env.nix
        ./modules/common-pkgs.nix
        ./hosts/${name}/configuration.nix
        ./hosts/${name}/hardware-configuration.nix
      ];
      mkSystem = name: cfg: nixpkgs.lib.nixosSystem {
        system = cfg.system or "x86_64-linux";
        modules = (common-modules name) ++ (cfg.modules or []);
        specialArgs = inputs // { inherit name; };
      };
      systems = {
        homebody = {
          modules = [
            ./modules/desktop.nix
          ];
        };
        bakery = {
          modules = [
            ./modules/desktop.nix
          ];
        };
        theplug = {};
        plantation = {};
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;
    };
}
