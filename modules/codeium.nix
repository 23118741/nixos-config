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
              -- We removed the 'tools' table. 
              -- This tells Codeium to download the correct version automatically.
          })
        '';
      };
    };
  };
}
