{ 
  pkgs,
  vars,
  inputs,
  config,
  ... 
}: {
  home.stateVersion = "24.11"; # Do not change

  home.file = {}; # Plain files

  home.packages = with pkgs; [
    btop
    brightnessctl
    ripgrep
    tree
    typst
    unzip
    zip

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  imports = [
    (import ./default.nix { inherit vars; })

    # Desktop
    ./desktop/cliphist.nix

    (import ./desktop/fonts.nix { inherit vars pkgs; })
    (import ./desktop/hypridle.nix { inherit vars pkgs; })
    ./desktop/hyprland.nix
    (import ./desktop/hyprlock.nix { inherit vars pkgs; })
    (import ./desktop/hyprpaper.nix { inherit vars; })
    (import ./desktop/waybar.nix { inherit vars pkgs; })
    (import ./desktop/xdg.nix { inherit pkgs; })

    # Tools
    ./tools/bat.nix
    (import ./tools/git.nix { inherit vars; })
    ./tools/nvim.nix
    ./tools/ssh.nix
    (import ./tools/zsh.nix { inherit pkgs; })

    # Programs
    ./programs/alacritty.nix
    (import ./programs/firefox.nix { inherit vars inputs; })
  ];

}
