# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

# Make user monitor configuration available 
# let
#   monitorsXmlContent = builtins.readFile /home/carsoncall/.config/monitors.xml;
#   monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;
# in

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Enable GDM to use monitor configuration
  # systemd.tmpfiles.rules = [
  #   "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
  # ];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.carsoncall = {
    isNormalUser = true;
    description = "Carson Call";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.tailscale.enable = true;
  virtualisation.docker.enable = true;

  # Enable the Steam stuff 
  programs.steam.enable = true;
  hardware.opengl = {
    # Mesa 
    enable = true;
    # Vulkan 
    driSupport = true;
    # Rocm support and vulkan drivers 
    extraPackages = with pkgs; [ rocmPackages.clr.icd amdvlk ];
  };

  services.syncthing = {
    enable = true;
    user = "carsoncall";
    dataDir = "/home/carsoncall/syncthing";
    configDir = "/home/carsoncall/syncthing/.config/";
  };

  # This is to enable Vial to communicate with USB keyboards
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  system.stateVersion = "23.11";

}
