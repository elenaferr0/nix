{
  nixpkgs,
  inputs,
  outputs,
}:
{
  host,
}:
let
  lib = nixpkgs.lib;

  # TODO: Add darwin hosts
  hosts = lib.attrNames (outputs.nixosConfigurations);

  hostConfig = import (../hosts + "/${host}");
  vars = import (../hosts + "/${host}" + "/vars.nix");
  system = vars.arch;
  darwin = (builtins.match ".*darwin$" vars.arch) != null;
  systemFunction = if darwin then inputs.nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;

  home-manager = if darwin then
      inputs.home-manager.darwinModules.home-manager
    else
      inputs.home-manager.nixosModules.home-manager;
in
systemFunction {
  inherit system;

  specialArgs = {
    inherit host;
    inherit inputs;
    inherit darwin;
    inherit hosts;
  };

  modules = [
    home-manager
    ../configuration.nix
    hostConfig
  ];
}
