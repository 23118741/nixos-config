{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    extraPackages = with pkgs; [ curl ];

    extraPlugins = with pkgs.vimPlugins; {

      # Remove 'setup' here to let Avante handle it
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
                -- Explicitly point to the OpenAI-compatible endpoint
                endpoint = "https://generativelanguage.googleapis.com/v1beta/openai/",
                
                -- Use the exact versioned model name
                model = "gemini-1.5-flash-latest",
                
                -- Ensure the key name is set
                api_key_name = "GEMINI_API_KEY",
                
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
