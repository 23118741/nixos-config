{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    # Codeium requirements
    extraPackages = with pkgs; [
      gzip
      curl
      coreutils
    ];

    extraPlugins = with pkgs.vimPlugins; {

      # CHANGE: The package name is now 'windsurf-nvim'
      windsurf-nvim = {
        package = windsurf-nvim;

        # We still try to require "codeium" first.
        # If this fails later, we will try "windsurf".
        setup = ''
          require("codeium").setup({
              enable_chat = true
          })
        '';
      };
    };
  };
}
