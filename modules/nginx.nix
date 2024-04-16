{ lib, config, pkgs, ... }:

{
    services.nginx = {
        enable = true;
        recommendedOptimisation = true;
        recommendedGzipSettings = true;
        recommendedProxySettings = true;

        # Configure Nginx to listen on Tailscale's assigned IP. Only changes if Tailscale is reset/reinstalled
        virtualHosts."100.66.89.118" = {
            locations."/gitea" = {
                proxyPass = "http://localhost:3000"; # Adjust port as needed
            };
            # locations."/nextcloud" = {
            #     proxyPass = "http://localhost:8080"; # Adjust port as needed
            };
    };
}