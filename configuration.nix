# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  config,
  pkgs,
  ... 
}: {
  imports = [
   ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    home-manager
    git
    curl
    neovim
    wl-clipboard
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
