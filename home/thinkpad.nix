{ 
  pkgs,
  vars,
  ... 
}: {
  home.stateVersion = "24.11"; # Do not change

  home.file = {}; # Plain files

  imports = [
    (import ./default.nix { inherit vars; })

    # Desktop
    ./desktop/cliphist.nix
    ./desktop/fonts.nix
    ./desktop/hypridle.nix
    ./desktop/hyprland.nix
    ./desktop/hyprlock.nix
    ./desktop/hyprpaper.nix
    (import ./desktop/waybar.nix { inherit vars pkgs; })
    ./desktop/xdg.nix

    # Tools
    ./tools/bat.nix
    ./tools/git.nix
    ./tools/nvim.nix
    ./tools/ssh.nix
    ./tools/zsh.nix

    # Programs
    ./programs/alacritty.nix
    ./programs/firefox.nix
  ];

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
}
