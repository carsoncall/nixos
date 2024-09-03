{ config, pkgs, ... }:
in {

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

    # I D WHEE
    zellij
    joshuto
    alacritty
    chatgpt-cli
    fzf
    helix
    neo4j
    neo4j-desktop

    # language servers
    jdt-language-server
    nodePackages.typescript-language-server
    rust-analyzer
    delve
    golangci-lint-langserver

    # # utilities
    unzip
    jq
    groff
    lsd
    qt6.full
    zip

    # # gnome extensions
    gnomeExtensions.caffeine
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.system-monitor-next
    gnomeExtensions.gtile

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

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
    ".config/nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';
    ".config/alacritty/alacritty.toml".text = ''
      [shell] 
      program = "/etc/profiles/per-user/carsoncall/bin/fish"
      args =  ["--command=zellij"]

      [font.normal]
      family = "JetBrainsMono Nerd Font"
      style = "Medium"

      [font.bold]
      family = "JetBrainsMono Nerd Font"
      style = "Heavy"

      [font.italic]
      family = "JetBrainsMono Nerd Font"
      style = "Medium Italic"

      # Colors (Everforest Dark) https://github.com/alacritty/alacritty-theme/blob/master/themes/everforest_dark.toml

      # Default colors
      [colors.primary]
      background = '#2d353b'
      foreground = '#d3c6aa'

      # Normal colors
      [colors.normal]
      black   = '#475258'
      red     = '#e67e80'
      green   = '#a7c080'
      yellow  = '#dbbc7f'
      blue    = '#7fbbb3'
      magenta = '#d699b6'
      cyan    = '#83c092'
      white   = '#d3c6aa'

      # Bright colors
      [colors.bright]
      black   = '#475258'
      red     = '#e67e80'
      green   = '#a7c080'
      yellow  = '#dbbc7f'
      blue    = '#7fbbb3'
      magenta = '#d699b6'
      cyan    = '#83c092'
      white   = '#d3c6aa'
    '';

    ".config/zellij/config.kdl".source = ./../../modules/config.kdl;
    ".config/helix/config.toml".source = ./../../modules/helix/config.toml;
    ".config/helix/languages.toml".source =
      ./../../modules/helix/languages.toml;
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
    EDITOR = "hx";
    SHELL = "${pkgs.zsh}/bin/zsh";
    # NIXOS_OZONE_WL = "1";
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      enableCompletion = false;
      shellAliases = {
        js =
          "joshuto --output-file /tmp/joshutodir; LASTDIR=`cat /tmp/joshutodir`; cd $LASTDIR";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "systemd" ];
        theme = "terminalparty";
      };
    };

    firefox = { enable = true; };

    fish = { enable = true; };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

  };


    # "/org/gnome/desktop/screensaver" = {
    #   picture-uri = "/run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
    # };

    # "/org/gnome/desktop/background" = {
    #   picture-uri = "/run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
    #   picture-uri-dark = "/run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
    #   primary-color = "#241f31";
    # };

  };
}
