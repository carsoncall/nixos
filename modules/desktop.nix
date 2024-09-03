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
  pavucontrol
  home-manager
  zip
  unzip
  groff
  lsd

  # music
  cider

  # browsers
  firefox
  google-chrome

  # productivity
  libreoffice
  obsidian
  gnome-photos
  gimp

  # hobby
  vial

  # gnome extensions
  gnomeExtensions.caffeine
  gnomeExtensions.quick-settings-audio-panel
  gnomeExtensions.system-monitor-next
  gnomeExtensions.gtile

  # general programming
  git
  gh
  zellij
  joshuto
  alacritty
  chatgpt-cli
  fzf
  helix
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
