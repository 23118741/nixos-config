{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      # ── System ───
      update-system = "cd ~/nixos-config && git pull && sudo nixos-rebuild switch --flake .#default --impure echo 'System updated!'";
      please = "sudo"; # polite sudo

      # ── Project: Veiling ───
      veiling = "cd ~/Projects/github.com/guus/VeilingAIWebApplicatieRealNotFake";

      # We use 'direnv exec .' to force load the flake tools before running
      frontend = "veiling && direnv exec . npm run dev --prefix frontend";
      backend = "veiling && ASPNETCORE_URLS=http://localhost:5000 direnv exec . dotnet watch --project backend";
      db-up = "veiling && direnv exec . docker compose up -d";
      db-down = "veiling && direnv exec . docker compose down";

      # ── Utils ─────
      ls = "ls --color=auto";
      ll = "ls -lah";
      grep = "grep --color=auto";

      # ── Git ───────
      ga = "git add .";
      gc = "git commit -m";
      gp = "git push";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
