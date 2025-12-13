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
          require('avante').setup({
            provider = "openai",

            -- Keep off to prevent Rate Limit errors
            auto_suggestions = false,
            dual_boost = { enabled = false },

            providers = {
              openai = {
                endpoint = "https://openrouter.ai/api/v1",

                -- THE STABLE CHOICE
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
        '';}
      };
    };
  };
}
