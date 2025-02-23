{
  description = "Home Manager configuration";
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, systems, home-manager, ... }:
    let
      inherit (self) outputs;
      vars = import ./vars.nix;
      lib = import ./lib {
        inherit
        self
        inputs
        nixpkgs
        outputs
	;
      };
    in {
      inherit lib;

      darwinConfigurations = {};

      nixosConfigurations = {
        thinkpad = lib.mkSystem {
	  host = "thinkpad";
	};
      };
    #   nixosConfigurations."${vars.hostname}" = nixpkgs.lib.nixosSystem {
    #   pkgs = nixpkgs.legacyPackages."${vars.arch}";
    #
    #   modules = [
    #     ./machines/thinkpad.nix
    #     ./configuration.nix
    #
    #     home-manager.nixosModules.home-manager
    #     {
    #       home-manager.useGlobalPkgs = true;
    #       home-manager.useUserPackages = true;
    #       home-manager.backupFileExtension = "bak";
    #       home-manager.users."${vars.user}" = {
    #         imports = [
    #           ./home
    #         ];
    #       };
    #       # home-manager.sharedModules = [
    #       #   nix-index-database.hmModules.nix-index
    #       # ];
    #       home-manager.extraSpecialArgs = {
    #         vars = vars;
    #         inputs = inputs;
    #       };
    #     }
    #   ];
    # };
  };
}
