{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # network
    wget
    curl
    nmap

    # editors
    helix
    vim
    nano

    # cli tools
    lsd
    fish
    git
    zellij
    helix
    ripgrep
    fzf

    # compression
    unzip
    zip
    gzip
    gnutar
  ];
}
