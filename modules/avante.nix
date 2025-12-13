{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    extraPackages = with pkgs; [ curl ];

    extraPlugins = with pkgs.vimPlugins; {

      # --- Dependencies ---
      # We remove the 'setup' here because we will manually load it below
      dressing-nvim = {
        package = dressing-nvim;
      };
      nui-nvim = {
        package = nui-nvim;
      };
      plenary-nvim = {
        package = plenary-nvim;
      };

      # --- Main Plugin ---
      avante-nvim = {
        package = avante-nvim;
        setup = ''
          -- 1. Force load the UI dependency FIRST
          require('dressing').setup()

          -- 2. Now load Avante
          require('avante').setup({
            provider = "gemini", 
            
            providers = {
              gemini = {
                model = "gemini-1.5-flash",
                temperature = 0,
                max_tokens = 4096,
              },
            },
          })
        '';
      };
    };
  };
}
