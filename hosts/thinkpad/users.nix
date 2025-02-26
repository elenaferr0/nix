{
  pkgs,
  vars,
  config,
  inputs,
  ...
}: {
  programs.zsh.enable = true;
  users.groups."${vars.user}" = {};
  users.users."${vars.user}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" vars.user "docker"];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;

  home-manager.users."${vars.user}" = import ../../home/${vars.hostname}.nix {inherit vars pkgs config inputs;};
}
