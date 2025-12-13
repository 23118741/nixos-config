{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    # Codeium needs these system tools to run its language server
    extraPackages = with pkgs; [
      gzip
      curl
      uname
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
