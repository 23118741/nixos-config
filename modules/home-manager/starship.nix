{ pkgs, ... }:

{
  programs.starship = {
    enable = true;

    # We don't need enableBashIntegration here because Home Manager
    # handles it automatically if programs.bash is enabled in the other file.

    settings = {
      add_newline = true;
      line_break = {
        disabled = false;
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold cyan";
      };

      username = {
        style_user = "white bold";
        show_always = false;
      };
      hostname = {
        ssh_only = true;
      };
    };
  };
}
