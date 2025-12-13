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
            
            providers = {
              openai = {
                endpoint = "https://generativelanguage.googleapis.com/v1beta/openai/",
                model = "gemini-1.5-flash",
                api_key_name = "GEMINI_API_KEY",
                
                -- FIX: Move parameters inside this new table
                extra_request_body = {
                  temperature = 0,
                  max_tokens = 4096,
                },
              },
            },
          })
        '';
      };
    };
  };
}
