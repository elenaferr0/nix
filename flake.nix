{
  description = "Home Manager configuration";
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-gnome-theme = { 
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
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
  };
}
