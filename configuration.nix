# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
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
    curl
    gcc
    git
    home-manager
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    neovim
    python314
    wl-clipboard
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
