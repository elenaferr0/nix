{
  vars,
  ...
}:
{
  home.username = vars.user;
  home.homeDirectory = vars.homeDirectory;
  programs.home-manager.enable = true;
}
