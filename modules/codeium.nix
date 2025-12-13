{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    extraPackages = with pkgs; [
      gzip
      curl
      coreutils
      # 1. Install the official NixOS Codeium binary
      codeium
    ];

    extraPlugins = with pkgs.vimPlugins; {
      windsurf-nvim = {
        package = windsurf-nvim;

        # 2. Point the plugin to the NixOS binary
        setup = ''
          require("codeium").setup({
              enable_chat = true,
              tools = {
                  -- This is the magic line that fixes it on NixOS
                  language_server = "${pkgs.codeium}/bin/codeium_language_server",
              }
          })
        '';
      };
    };
  };
}
