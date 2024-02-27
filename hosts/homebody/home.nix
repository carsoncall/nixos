{ config, pkgs, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "carsoncall";
  home.homeDirectory = "/home/carsoncall";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # programs.vscode.package = pkgs.vscode.fhsWithPackages (ps: with ps; [ 
  #     rustup
  #     zlib
  #     openssl.dev
  #     pkg-config
  #   ]);
  home.packages = with pkgs; [
    signal-desktop
    slack
    protonvpn-gui
    cider
    mumble
    pavucontrol
    obsidian
    firefox
    discord
    zoom
    home-manager
    teams-for-linux
    gh
    gnome-photos
    gimp
    vial
    libreoffice

    # # Programming
    nil
    git
    maven
    jdk17
    jetbrains.idea-community
    nodejs_21
    python3
    cargo
    rustc
    gcc
    vscode-fhs

    # I D WHEE
    zellij
    ranger

    # # utilities
    unzip
    jq

    # # gnome extensions
    gnomeExtensions.caffeine
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.system-monitor-next
    gnomeExtensions.gtile

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/carsoncall/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    SHELL = "${pkgs.zsh}/bin/zsh";
    # NIXOS_OZONE_WL = "1";
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      enableCompletion = false;
      shellAliases = {
        home-edit = "nano /home/carsoncall/nixos/hosts/homebody/home.nix";
        conf-edit =
          "nano /home/carsoncall/nixos/hosts/homebody/configuration.nix";
        update =
          "sudo nixos-rebuild switch --flake /home/carsoncall/nixos#homebody";
        clean = "sudo nix-collect-garbage --delete-older-than 7d";
        update-extensions = ''
          sh /home/carsoncall/code/nixpkgs/pkgs/applications/editors/vscode/extensions/update_installed_exts.sh
                                       >> ~/nixos/hosts/homebody/extensions.json'';
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "systemd" ];
        theme = "terminalparty";
      };
    };

    helix = {
      enable = true;
      settings = {
        theme = "autumn_night_transparent";
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }];
      themes = {
        autumn_night_transparent = {
          "inherits" = "autumn_night";
          "ui.background" = { };
        };
      };
    };

    alacritty = { enable = true; };

    firefox = { enable = true; };

    fish = { enable = true; };

  };

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Settings.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Console.desktop"
        "firefox.desktop"
        "code.desktop"
        "steam.desktop"
        "signal-desktop.desktop"
        "protonvpn-app.desktop"
        "mumble.desktop"
        "obsidian.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-date = true;
      clock-show-weekday = true;
      clock-format = "24h";
      enable-hot-corners = false;
    };

    # "/org/gnome/desktop/screensaver" = {
    #   picture-uri = "/run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
    # };

    # "/org/gnome/desktop/background" = {
    #   picture-uri = "/run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
    #   picture-uri-dark = "/run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
    #   primary-color = "#241f31";
    # };

    "org/gnome/mutter" = { edge-tiling = true; };
  };
}
