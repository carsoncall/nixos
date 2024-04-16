{ config, lib, pkgs, ... }:

{
  # Add the necessary Nix packages for Gitea and any other dependencies
  environment.systemPackages = with pkgs; [
    gitea
    # Add other packages as needed
  ];

  services.gitea = {
    enable = true;
    appName = "My awesome Gitea server"; # Give the site a name
    database = {
      type = "postgres";
    };
    settings.server = { 
      domain = "100.66.89.118/gitea";
      rootUrl = "http://100.66.89.118:3000";
      httpPort = 3000;
    };
    
  };
}
