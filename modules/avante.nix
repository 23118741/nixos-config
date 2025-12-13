{ pkgs, ... }:

{
  # We use the full path so this file is a valid standalone module
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
            auto_suggestions = false,
            
            providers = {
              openai = {
                endpoint = "https://openrouter.ai/api/v1",
                model = "mistralai/codestral-2501:free",
                api_key_name = "OPENROUTER_API_KEY",
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
