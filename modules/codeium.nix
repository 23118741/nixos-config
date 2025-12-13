{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    # Codeium requirements
    extraPackages = with pkgs; [
      gzip
      curl
      coreutils # <--- Changed from 'uname' to 'coreutils'
    ];

    extraPlugins = with pkgs.vimPlugins; {
      codeium-nvim = {
        package = codeium-nvim;
        setup = ''
          require("codeium").setup({
              enable_chat = true
          })
        '';
      };
    };
  };
}
