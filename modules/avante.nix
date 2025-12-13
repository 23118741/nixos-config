{ pkgs, ... }:

{
  # We use the "Partial Path" (vim =) to match your existing config style.
  vim.extraPlugins = with pkgs.vimPlugins; {

    # --- Dependencies (Required) ---
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
      # Minimal setup: No providers, no AI keys yet. Just loading the code.
      setup = "require('avante').setup({ provider = 'openai', auto_suggestions_provider = 'openai' })";
    };
  };
}
