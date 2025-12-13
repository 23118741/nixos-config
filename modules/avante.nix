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
          require('dressing').setup()

          require('avante').setup({
            provider = "openai", 
            
            -- Disable ghost text to save Rate Limits
            auto_suggestions = false,
            
            -- Disable dual boost (it often triggers the Tool ID error)
            dual_boost = { enabled = false },

            providers = {
              openai = {
                endpoint = "https://openrouter.ai/api/v1",
                
                -- FIX: Use Mistral Nemo.
                -- Devstral (2512) is broken on OpenRouter for tools/function calling right now.
                model = "mistralai/mistral-nemo:free",
                
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
