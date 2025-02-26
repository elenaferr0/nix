{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  vars = import ./vars.nix;
in {
  imports = [
    ../common/locale.nix
    (import ../common/networking.nix {inherit vars;})
    ../common/nix.nix

    ./keymap.nix
    ./printing.nix
    ./sound.nix
    (import ./users.nix {inherit vars pkgs config inputs;})
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = [pkgs.mesa.drivers];
  };

  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  virtualisation.docker.enable = true;
}
