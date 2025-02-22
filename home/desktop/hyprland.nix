{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
      ];
      animations = {
        enabled = false;
      };
      input = {
        repeat_rate = 40;
        repeat_delay = 300;
        kb_layout = "us,it";
        kb_options = "grp:mod_x_toggle";
        # kb_options = "grp:alt_space_toggle";
      };

      device = [
        {
          name = "etps/2-elantech-touchpad";
          sensitivity = 0.1;
          accel_profile = "adaptive";

          natural_scroll = false;
          drag_lock = true;
        }
      ];

      misc = {
        vrr = true;
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = true;
        swallow_regex = "^(alacritty)$";
      };

      "$mod" = "SUPER";
      bind =
        [
          "$mod, Escape, exec, hyprlock -q"
          "$mod, Space, exec, bemenu-run"
          "$mod, Return, exec, alacritty"
          "$mod, Q, killactive,"
	  "$mod, V, togglefloating"
	  # nautilus mod N
	  "$mod, space, togglesplit"
	  "$mod, F, fullscreen, 1" # maximize
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        )
        ++ [
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
	]
	++ [
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"
        ];
	# TODO: screenshot shortcuts
	# TODO: powermenu shortcuts
      bindle = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrevious, exec, playerctl previous"
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86MonBrightnessUp, exec, light -A 2"
        ", XF86MonBrightnessDown, exec, light -U 2"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      windowrulev2 = [
        "float,title: Calculator"
        "float,title: Calendar"
	# Rules for Jetbrains products
	"float,floating:0,class:^(jetbrains-.*),title:^(win.*)"
	"float,class:^(jetbrains-.*),title:^(Welcome to.*)"
	"center,class:^(jetbrains-.*),title:^(Replace All)$"
	"allowsinput,class:^(jetbrains-.*)"
      ];
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        "DP-4,1920x1080@60,1920x0,1"
      ];
    };
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
