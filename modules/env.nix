{ pkgs, name, ... }:
{
  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.carsoncall = {
    isNormalUser = true;
    description = "Carson Call";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      # shell scripts
      (pkgs.writeShellScriptBin "conf-edit" ''
        $EDITOR /home/carsoncall/nixos/hosts/${name}/configuration.nix
      '')

      (pkgs.writeShellScriptBin "update" ''
        sudo nixos-rebuild switch --flake /home/carsoncall/nixos#${name}
      '')
    ];
  };
  systemd.user.services.sync-dotfiles = {
    description = "Sync Dotfiles from GitHub";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "sync-dotfiles" ''
        set -eo pipefail
        DEST_DIR="$HOME/.dotfiles"
        REPO_URL="https://github.com/carsoncall/dotfiles.git"
        # Clone or pull updates based on the existence of the directory
        if [[ -d "$DEST_DIR" ]]; then
          cd "$DEST_DIR"
          # Optionally, add condition to check if remote is newer
          echo ".dotfiles already exists! remember to use the config alias to add, commit, push, pull, and branch"
          git pull --rebase
        else
          git clone --bare "$REPO_URL" "$DEST_DIR"
        fi
      '';
    };
  };
}
