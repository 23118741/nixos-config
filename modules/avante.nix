{ pkgs, ... }:

{
  # We must use the full path here because this file is loaded via 'imports'
  programs.nvf.settings.vim.extraPlugins = with pkgs.vimPlugins; {

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
      setup = "require('avante').setup({ provider = 'openai', auto_suggestions_provider = 'openai' })";
    };
  };
}
