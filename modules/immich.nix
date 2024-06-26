{ stdenv, docker-compose, fetchurl, pkgs, ... }:
stdenv.mkDerivation rec {
    name = "immich-current";
    version = "1.0";
    src = fetchurl {
        url = "https://github.com/immich-app/immich/releases/latest/download/";
        sha256 = "";
        # sparseCheckout = [
        #     "docker-compose.yml"
        #     "hwaccel.yml"
        # ];
        
    };
    env = pkgs.writeText ".env" ''
        ###################################################################################
        # Database
        ###################################################################################

        DB_HOSTNAME=immich_postgres
        DB_USERNAME=postgres
        DB_PASSWORD=postgres
        DB_DATABASE_NAME=immich

        # Optional Database settings:
        # DB_PORT=5432

        ###################################################################################
        # Redis
        ###################################################################################

        REDIS_HOSTNAME=immich_redis

        # Optional Redis settings:

        # Note: these parameters are not automatically passed to the Redis Container
        # to do so, please edit the docker-compose.yml file as well. Redis is not configured
        # via environment variables, only redis.conf or the command line

        # REDIS_PORT=6379
        # REDIS_DBINDEX=0
        # REDIS_PASSWORD=
        # REDIS_SOCKET=

        ###################################################################################
        # Upload File Location
        #
        # This is the location where uploaded files are stored.
        ###################################################################################

        UPLOAD_LOCATION=absolute_location_on_your_machine_where_you_want_to_store_the_backup


        ###################################################################################
        # Log message level - [simple|verbose]
        ###################################################################################

        LOG_LEVEL=simple

        ###################################################################################
        # Typesense
        ###################################################################################
        # TYPESENSE_ENABLED=false
        TYPESENSE_API_KEY=some-random-text
        # TYPESENSE_HOST: typesense
        # TYPESENSE_PORT: 8108
        # TYPESENSE_PROTOCOL: http

        ###################################################################################
        # Reverse Geocoding
        #
        # Reverse geocoding is done locally which has a small impact on memory usage
        # This memory usage can be altered by changing the REVERSE_GEOCODING_PRECISION variable
        # This ranges from 0-3 with 3 being the most precise
        # 3 - Cities > 500 population: ~200MB RAM
        # 2 - Cities > 1000 population: ~150MB RAM
        # 1 - Cities > 5000 population: ~80MB RAM
        # 0 - Cities > 15000 population: ~40MB RAM
        ####################################################################################

        # DISABLE_REVERSE_GEOCODING=false
        # REVERSE_GEOCODING_PRECISION=3

        ####################################################################################
        # WEB - Optional
        #
        # Custom message on the login page, should be written in HTML form.
        # For example:
        # PUBLIC_LOGIN_PAGE_MESSAGE="This is a demo instance of Immich.<br><br>Email: <i>demo@demo.de</i><br>Password: <i>demo</i>"
        ####################################################################################

        PUBLIC_LOGIN_PAGE_MESSAGE="My Family Photos and Videos Backup Server"

        ####################################################################################
        # Alternative Service Addresses - Optional
        #
        # This is an advanced feature for users who may be running their immich services on different hosts.
        # It will not change which address or port that services bind to within their containers, but it will change where other services look for their peers.
        # Note: immich-microservices is bound to 3002, but no references are made
        ####################################################################################

        IMMICH_WEB_URL=http://immich-web:3000
        IMMICH_SERVER_URL=http://immich-server:3001

        ####################################################################################
        # Alternative API's External Address - Optional
        #
        # This is an advanced feature used to control the public server endpoint returned to clients during Well-known discovery.
        # You should only use this if you want mobile apps to access the immich API over a custom URL. Do not include trailing slash.
        # NOTE: At this time, the web app will not be affected by this setting and will continue to use the relative path: /api
        # Examples: http://localhost:3001, http://immich-api.example.com, etc
        ####################################################################################

        #IMMICH_API_URL_EXTERNAL=http://localhost:3001

        ###################################################################################
        # Immich Version - Optional
        #
        # This allows all immich docker images to be pinned to a specific version. By default,
        # the version is "release" but could be a specific version, like "v1.59.0".
        ###################################################################################

        #IMMICH_VERSION=
    '';

    installPhase = ''
    mkdir $out/immich-app
    cp {docker-compose.yml, $.env, hwaccel.yml} $out/immich-app
    docker-compose $out/immich-app/docker-compose.yml -d
    '';
}