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
            
            -- We use 'vendors' but fully define it to avoid the deprecation warning
            vendors = {
              groq = {
                endpoint = "https://api.groq.com/openai/v1/chat/completions",
                model = "llama-3.3-70b-versatile",
                api_key_name = "GROQ_API_KEY",
                
                -- Explicitly define how to handle the request (Bulletproof method)
                parse_curl_args = function(opts, code_opts)
                  return {
                    url = opts.endpoint,
                    headers = {
                      ["Accept"] = "application/json",
                      ["Content-Type"] = "application/json",
                      ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
                    },
                    body = {
                      model = opts.model,
                      messages = require("avante.providers").openai.parse_messages(code_opts),
                      temperature = 0,
                      max_tokens = 4096,
                      stream = true,
                    },
                  }
                end,
                
                -- Explicitly define how to read the response
                parse_response_data = function(data_stream, event_state, opts)
                  require("avante.providers").openai.parse_response(data_stream, event_state, opts)
                end,
              },
            },
          })
        '';
      };
    };
  };
}
