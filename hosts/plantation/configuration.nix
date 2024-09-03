# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/postgresql.nix
      ../../modules/jellyfin.nix
      ../../modules/common-pkgs.nix
      ../../modules/env.nix
    ];
  # Bootloader. 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  #Instructions for tailscale found on their website here: https://tailscale.com/download/linux/nixos
  services.tailscale.enable = true;
  networking.nameservers = ["100.100.100.100" "1.1.1.1"];
  networking.search = ["tail4c156.ts.net"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  services.openssh.enable = true;
  services.murmur = {
    enable = true;
    port = 10000;
  };
  
  virtualisation.docker.enable = true;

  # don't mess with this
  system.stateVersion = "23.05";
}
