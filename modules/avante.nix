{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    extraPackages = with pkgs; [ curl ];

    extraPlugins = with pkgs.vimPlugins; {
      dressing-nvim = {
        package = dressing-nvim;
        setup = "require('dressing').setup()";
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
            -- Change provider to gemini
            provider = "gemini", 
            
            providers = {
              gemini = {
                __inherited_from = "openai",
                api_key_name = "GEMINI_API_KEY",
                endpoint = "https://generativelanguage.googleapis.com/v1beta/openai/",
                model = "gemini-1.5-flash",
                max_tokens = 4096,
              },
            },
          })
        '';
      };
    };
  };
}
