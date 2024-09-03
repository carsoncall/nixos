{ ... }:
{
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = false; # change to "true" to prevent overriding
        settings = {
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

          "org/gnome/mutter" = { edge-tiling = true; };
        };
      }
    ];
  };
}
