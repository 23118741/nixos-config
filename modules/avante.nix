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
            provider = "gemini", 
            
            -- Keep this FALSE to save API calls for when you actually ask questions
            auto_suggestions = false, 
            
            -- Keep this FALSE to save tokens (it runs the prompt twice otherwise)
            dual_boost = { enabled = false },

            providers = {
              gemini = {
                model = "gemini-2.5-flash",
                api_key_name = "GEMINI_API_KEY",
                temperature = 0,
                max_tokens = 30000,
              },
            },
          })
        '';
      };
    };
  };
}
