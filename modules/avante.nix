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
            provider = "openai", 
            
            -- Disable ghost text to save rate limits
            auto_suggestions = false,
            
            providers = {
              openai = {
                endpoint = "https://openrouter.ai/api/v1",
                
                -- The requested Mistral Devstral model
                model = "mistralai/devstral-2512:free",
                
                -- Your specific API Key variable name
                api_key_name = "API_KEY",
                
                timeout = 30000,
                
                extra_request_body = {
                  max_tokens = 8192,
                  temperature = 0,
                },
              },
            },
          })
        '';
      };
    };
  };
}
