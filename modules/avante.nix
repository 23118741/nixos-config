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
            
            -- Keep Ghost Text OFF to save RPM (Requests Per Minute)
            auto_suggestions = false,
            dual_boost = { enabled = false },

            providers = {
              gemini = {
                -- Switch to the LITE model found in your list
                -- This is the most efficient model for large context
                model = "gemini-2.0-flash-lite",
                
                api_key_name = "GEMINI_API_KEY",
                
                temperature = 0,
                
                -- Gemini Flash/Lite supports large output, 8192 is a safe max for summaries
                max_tokens = 8192,
              },
            },
          })
        '';
      };
    };
  };
}
