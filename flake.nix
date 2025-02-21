{
  description = "Home Manager configuration of elena";
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }:
    let
      vars = import ./vars.nix;
    in {
         nixosConfigurations."${vars.hostname}" = nixpkgs.lib.nixosSystem {
      pkgs = nixpkgs.legacyPackages."${vars.arch}";

      modules = [
        ./machines/thinkpad.nix
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users."${vars.user}" = {
            imports = [
              ./home
            ];
          };
          # home-manager.sharedModules = [
          #   nix-index-database.hmModules.nix-index
          # ];
          home-manager.extraSpecialArgs = {
            vars = vars;
            inputs = inputs;
          };
        }
      ];
    };
      # nixosConfigurations.""
      # system = vars.arch;
      # pkgs = nixpkgs.legacyPackages.${system};
      # homeConfigurations."elena" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #
      #   # Specify your home configuration modules here, for example,
      #   # the path to your home.nix.
      #   modules = [ ./home.nix ];
      #
      #   # Optionally use extraSpecialArgs
      #   # to pass through arguments to home.nix
      # };
    };
}
