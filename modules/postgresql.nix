{ lib, config, pkgs, ... }:

{
  # Define the PostgreSQL database server
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14;
    dataDir = "/var/lib/data/postgresql";

    # Define PostgreSQL databases for Gitea and Nextcloud
    ensureDatabases = [
      "gitea"
      "nextcloud"
      "immich"
    ];
    ensureUsers = [
      {
        name = "gitea";
        ensurePermissions = {
          "DATABASE gitea" = "ALL PRIVILEGES";
        };
      }
      {
        name = "nextcloud";
        ensurePermissions = {
          "DATABASE nextcloud" = "ALL PRIVILEGES";
        };
      }
      {
        name = "immich";
        ensurePermissions = {
          "DATABASE immich" = "ALL PRIVILEGES";
        };
      }
    ];

    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser auth-method
      local sameuser all    trust
      local gitea    gitea  trust
      local nextcloud nextcloud trust
      local immich   immich trust
      '';
    

    # # PostgreSQL server configuration
    # serverConfig = {
    #   listenAddresses = [ "localhost" ]; # Listen only on localhost for security
    #   maxConnections = 10; # Adjust as needed
    #   sharedBuffers = 262144
    #   ; # Adjust according to available RAM
    # };

    # # Define PostgreSQL users (for Gitea and Nextcloud)
    # users = {
    #   gitea = {
    #     ensure = "present";
    #     name = "gitea"; # PostgreSQL user for Gitea
    #     passwordFile = "/etc/nixos/gitea_db_user_password"; # Store the password securely
    #   };
    #   nextcloud = {
    #     ensure = "present";
    #     name = "nextcloud"; # PostgreSQL user for Nextcloud
    #     passwordFile = "/etc/nixos/nextcloud_db_user_password"; # Store the password securely
    #   };
    # };
  };
}
