{ pkgs, ... }:

{
  # 1. Bash Configuration (Aliases & Behavior)
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      cdev = "cd $HOME/Dev/github.com/guus";

      # Useful git aliases
      gs = "git status";
      gc = "git commit";
      gp = "git push";
    };
  };

  # 2. Direnv (Project Environment Manager)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
