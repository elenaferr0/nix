# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  config,
  pkgs,
  ... 
}: let
  vars = import ./vars.nix;
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = vars.hostname;
    firewall = {
      enable = true;
      logReversePathDrops = true;
      checkReversePath = "loose";
    };
    nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        scanRandMacAddress = true;
        macAddress = "random"; # "stable-ssid";
      };
      settings = {
        connectivity = {
          interval = 0;
        };
      };
    };
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Print services
  services.printing = {
    enable = true;
    drivers = [
      pkgs.gutenprint
      pkgs.gutenprintBin
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Sound
  security.rtkit.enable = true;
  services.dbus.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # User setup
  services.openssh.enable = true;
  programs.zsh.enable = true;
  users.groups."${vars.user}" = {};
  users.users."${vars.user}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" vars.user ];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    home-manager
    git
    curl
    neovim
    wl-clipboard
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
