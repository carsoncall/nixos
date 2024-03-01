{
  description = "Nixos config flake";

  inputs = {

    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "electron-25.9.0" ];
        };
      };
    in {
      nixosConfigurations = {
        homebody = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/homebody/configuration.nix
            ./hosts/homebody/hardware-configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        bakery = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/bakery/configuration.nix
            ./hosts/bakery/hardware-configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        plug = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/plug/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
      homeConfigurations = {
        homebody = inputs.home-manager.lib.homeManagerConfiguration {
          specialArgs = { inherit inputs pkgs; };
          modules = [ ./hosts/homebody/home.nix ];
        };
        bakery = inputs.home-manager.lib.homeManagerConfiguration {
          specialArgs = { inherit inputs pkgs; };
          modules = [ ./hosts/bakery/home.nix ];
        };
        plug = inputs.home-manager.lib.homeManagerConfiguration {
          specialArgs = { inherit inputs pkgs; };
          modules = [ ./hosts/plug/home.nix ];
        };
      };
    };
}
