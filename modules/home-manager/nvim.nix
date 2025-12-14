{
  pkgs,
  inputs,
  lib,
  ...
}:

let
  generalConfig = import ../nvf-config.nix { inherit pkgs; };
in
{
  imports = [
    inputs.nvf.homeManagerModules.default
    ../../modules/avante.nix
    ../../modules/codeium.nix
  ];

  programs.nvf = {
    enable = true;

    # Merge general config with our manual overrides
    settings = lib.mkMerge [
      generalConfig

      # Manual Override Block
      {
        vim = {
          autocomplete.nvim-cmp = {
            enable = true;
            mappings = {
              confirm = "<CR>";
              next = "<C-n>";
              previous = "<C-p>";
            };
          };

          # Enhanced diagnostic display for multiple languages
          lsp = {
            diagnostic = {
              enable = true;
              signs = true;
              virtual_text = {
                enable = true;
                prefix = " ";
                space_char = " ";
              };
              update_in_insert = false;
              severity = {
                error = "error";
                warning = "warning";
                information = "info";
                hint = "hint";
              };
            };

            typescript = {
              enable = true;
              on_attach = ''
                require('lsp_signature').on_attach()
                require('lsp-colors').setup()
              '';
            };

            html = {
              enable = true;
              on_attach = ''
                require('lsp_signature').on_attach()
                require('lsp-colors').setup()
              '';
            };

            css = {
              enable = true;
              on_attach = ''
                require('lsp_signature').on_attach()
                require('lsp-colors').setup()
              '';
            };

            json = {
              enable = true;
              on_attach = ''
                require('lsp_signature').on_attach()
                require('lsp-colors').setup()
              '';
            };
          };
        };

        # Enhanced diagnostic display for multiple languages
        lsp = {
          diagnostic = {
            enable = true;
            signs = true;
            virtual_text = {
              enable = true;
              prefix = " ";
              space_char = " ";
            };
            update_in_insert = false;
            severity = {
              error = "error";
              warning = "warning";
              information = "info";
              hint = "hint";
            };
          };

          # Language-specific LSP configurations
          csharp = {
            enable = true;
            on_attach = ''
              require('lsp_signature').on_attach()
              require('lsp-colors').setup()
            '';
          };

          typescript = {
            enable = true;
            on_attach = ''
              require('lsp_signature').on_attach()
              require('lsp-colors').setup()
            '';
          };

          html = {
            enable = true;
            on_attach = ''
              require('lsp_signature').on_attach()
              require('lsp-colors').setup()
            '';
          };

          css = {
            enable = true;
            on_attach = ''
              require('lsp_signature').on_attach()
              require('lsp-colors').setup()
            '';
          };

          json = {
            enable = true;
            on_attach = ''
              require('lsp_signature').on_attach()
              require('lsp-colors').setup()
            '';
          };
        };
      }
    ];
  };
}
