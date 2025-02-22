{ 
  config,
  pkgs,
  vars,
  ... 
}: {
  home.stateVersion = "24.11"; # Do not change
  home.username = vars.user;
  home.homeDirectory = vars.homeDirectory;

  programs.home-manager.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # or /etc/profiles/per-user/elena/etc/profile.d/hm-session-vars.sh

  imports = [
    # Desktop
    ./desktop/cliphist.nix
    ./desktop/fonts.nix
    ./desktop/hypridle.nix
    ./desktop/hyprland.nix
    ./desktop/hyprlock.nix
    ./desktop/hyprpaper.nix
    ./desktop/waybar.nix
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
