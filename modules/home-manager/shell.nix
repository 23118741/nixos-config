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
  shellAliases = {
    # Pull latest config from GitHub + rebuild
    update-system = "cd ~/nixos-config && git pull && sudo nixos-rebuild switch --flake .#default && echo 'System updated from GitHub!'";
  };
}
