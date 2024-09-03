{ pkgs, ... }:
with pkgs; [
  # social media
  signal-desktop
  slack
  mumble
  discord
  zoom-us
  teams-for-linux

  # system tools
  protonvpn-gui

  # sound
  pavucontrol
  home-manager

  # music
  cider

  # browsers
  firefox
  google-chrome
  chromium

  # productivity
  libreoffice
  obsidian
  gnome-photos
  gimp

  # hobby
  vial
  mediawriter

  # gnome extensions
  gnomeExtensions.caffeine
  gnomeExtensions.quick-settings-audio-panel
  gnomeExtensions.system-monitor-next
  gnomeExtensions.gtile

  # general programming
  gh
  joshuto
  alacritty
  chatgpt-cli
  vscode-fhs

  # c/c++
  gcc

  # go 
  go
  gopls
  delve

  # java
  jdt-language-server
  maven
  jdk17
  jetbrains.idea-community

  # javascript
  nodejs
  nodePackages.typescript-language-server

  # nix
  nil

  # python
  python3
  python311Packages.python-lsp-server

  # rust
  rustc
  rust-analyzer
  cargo

  # proprietary garbage
  awscli2
]
