{
  config,
  pkgs,
  vars,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    defaultEditor = true;
  };
}
