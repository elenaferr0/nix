{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.mesa.drivers ];
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
