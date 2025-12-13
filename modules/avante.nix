{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

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

      # UI Polish
      render-markdown-nvim = {
        package = render-markdown-nvim;
        setup = "require('render-markdown').setup({})";
      };

      # --- Main Plugin ---
      avante-nvim = {
        package = avante-nvim;
        setup = ''
          -- Force UI components to load first
          require('dressing').setup()
          require('render-markdown').setup()

          require('avante').setup({
            provider = "openai", 
            
            -- IMPORTANT: Ghost text is OFF because Codeium handles typing
            auto_suggestions = false,
            
            providers = {
              openai = {
                endpoint = "https://openrouter.ai/api/v1",
                
                -- STRICTLY AMAZON NOVA 2 LITE
                model = "amazon/nova-2-lite-v1:free",
                
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
