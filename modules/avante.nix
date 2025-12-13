{ pkgs, ... }:

{
  vim = {
    # Curl is required for API requests
    extraPackages = with pkgs; [ curl ];

    extraPlugins = with pkgs.vimPlugins; {

      # --- Dependencies ---
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
          -- 1. Force load UI first
          require('dressing').setup()

          -- 2. Configure Avante for OpenRouter (Mistral)
          require('avante').setup({
            -- We use the OpenAI driver because OpenRouter mimics OpenAI
            provider = "openai", 
            
            -- Disable auto-suggestions to prevent hitting Rate Limits
            auto_suggestions = false,
            
            providers = {
              openai = {
                endpoint = "https://openrouter.ai/api/v1",
                
                -- The OpenRouter ID for Mistral's Free Coding Model
                model = "mistralai/codestral-2501:free",
                
                api_key_name = "OPENROUTER_API_KEY",
                
                -- Mistral supports large context, but outputting 8k is safe
                max_tokens = 8192,
                
                temperature = 0,
              },
            },
          })
        '';
      };
    };
  };
}
