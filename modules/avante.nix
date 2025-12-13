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
            provider = "groq", 
            
            -- CHANGE: "vendors" is now "providers"
            providers = {
              groq = {
                __inherited_from = "openai",
                api_key_name = "GROQ_API_KEY",
                endpoint = "https://api.groq.com/openai/v1/",
                model = "llama-3.3-70b-versatile",
                max_tokens = 4096,
              },
            },
          })
        '';
      };
    };
  };
}
