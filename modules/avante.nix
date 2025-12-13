{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    # Avante needs curl to make API requests
    extraPackages = with pkgs; [ curl ];

    extraPlugins = with pkgs.vimPlugins; {

      # --- Dependencies ---
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

      # --- Main Plugin ---
      avante-nvim = {
        package = avante-nvim;
        setup = ''
          require('avante').setup({
            provider = "groq", 
            
            -- Configure Groq using the environment variable
            vendors = {
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
