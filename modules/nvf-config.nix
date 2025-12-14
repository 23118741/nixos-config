{ pkgs, ... }:
{
  vim = {
    extraPackages = with pkgs; [
      git
      nil
      nixfmt-rfc-style
    ];

    # Set Leader Key to Space
    globals.mapleader = " ";

    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;

    autocomplete.nvim-cmp = {
      enable = true;
      mappings.confirm = "<CR>";
    };

    lsp = {
      enable = true;
      formatOnSave = true;
    };
    treesitter = {
      enable = true;
      highlight.enable = true;
    };

    # Keybindings
    maps.normal = {
      "<leader>ff" = {
        action = ":Telescope find_files<CR>";
        desc = "Telescope Find Files";
      };
      "<leader>fg" = {
        action = ":Telescope live_grep<CR>";
        desc = "Telescope Live Grep";
      };
      "<leader>fb" = {
        action = ":Telescope buffers<CR>";
        desc = "Telescope Buffers";
      };
    };

    languages = {
      nix = {
        enable = true;

        lsp = {
          enable = true;
          servers = [ "nil" ];
        };

        format = {
          enable = true;
          type = "nixfmt";
        };
      };
      csharp = {
        enable = true;
        lsp = {
          enable = true;
          servers = "omnisharp";
        };
      };
    };
  };
}
