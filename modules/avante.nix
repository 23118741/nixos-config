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
            provider = "gemini", 
            
            providers = {
              gemini = {
                -- Using the specific model you found
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
