{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    extraPackages = with pkgs; [
      gzip
      curl
      coreutils
    ];

    extraPlugins = with pkgs.vimPlugins; {
      windsurf-nvim = {
        package = windsurf-nvim;
        setup = ''
          require("codeium").setup({
              enable_chat = true,
              
              -- FORCE VIRTUAL TEXT (The gray text)
              virtual_text = {
                  enabled = true,
                  -- Set to false to auto-trigger (default)
                  manual = false,
                  -- Ensure Tab key works
                  map_keys = true,
                  -- Ensure it works in all file types
                  filetypes = {
                      python = true,
                      javascript = true,
                      nix = true,
                  }
              }
          })
        '';
      };
    };
  };
}
