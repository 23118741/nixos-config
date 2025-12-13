{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    extraPackages = with pkgs; [ curl ];

    extraPlugins = with pkgs.vimPlugins; {

      # Remove setup here
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

          -- 2. Load Avante with Native Gemini support
          require('avante').setup({
            provider = "gemini", 
            
            providers = {
              gemini = {
                -- Do NOT specify 'endpoint'. Let Avante find Google automatically.
                
                -- This is the exact model name for the free tier
                model = "gemini-1.5-flash",
                
                api_key_name = "GEMINI_API_KEY",
                
                temperature = 0,
                max_tokens = 32000, -- Flash supports huge context
              },
            },
          })
        '';
      };
    };
  };
}
