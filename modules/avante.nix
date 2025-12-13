{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    extraPackages = with pkgs; [ curl ];

    extraPlugins = with pkgs.vimPlugins; {

      dressing-nvim = {
        package = dressing-nvim;
      };
      nui-nvim = {
        package = nui-nvim;
      };
      plenary-nvim = {
        package = plenary-nvim;
      };

      avante-nvim = {
        package = avante-nvim;
        setup = ''
          -- Force UI load
          require('dressing').setup()

          require('avante').setup({
            -- TRICK: We tell Avante we are using OpenAI
            provider = "openai", 
            
            providers = {
              openai = {
                -- But we point it to Google's compatibility endpoint
                endpoint = "https://generativelanguage.googleapis.com/v1beta/openai/",
                
                -- Use the Gemini model
                model = "gemini-1.5-flash",
                
                -- Use your Gemini Key
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
