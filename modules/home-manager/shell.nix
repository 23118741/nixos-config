{ pkgs, ... }:

{
  # 1. Bash Configuration (Aliases & Behavior)
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      # ── System updates ───────────────────────
      update-system = ''
        cd ~/nixos-config && 
        git pull && 
        sudo nixos-rebuild switch --flake .#default && 
        echo "System updated from GitHub!"
      '';

      # ── Web project shortcuts ─────────────────
      veiling = "cd ~/Dev/github.com/guus/VeilingAIWebApplicatieRealNotFake";
      backend = "veiling && cd backend && ASPNETCORE_URLS=http://localhost:5000 dotnet watch";
      frontend = "veiling && cd frontend && npm run dev";
      db-up = "veiling && docker compose up -d";
      db-down = "veiling && docker compose down";

      # ── General quality of life ───────────────
      ls = "ls --color=auto";
      ll = "ls -lah";
      grep = "grep --color=auto";
      please = "sudo"; # polite sudo
      # git shortcuts
      ga = "git add .";
      gc = "git commit -m";
      gp = "git push";
    };
  };
  # 2. Direnv (Project Environment Manager)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
