{
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    coc = {
      enable = true;
      settings = lib.importJSON ./coc-settings.json;
      pluginConfig = ''
        ${builtins.readFile ./coc.vim}
      '';
    };
    plugins = with pkgs.vimPlugins; [
      { plugin = dracula-nvim; optional = false; }
      { plugin = tokyonight-nvim; optional = false; }
      { plugin = catppuccin-nvim; optional = false; }

      { plugin = mini-nvim; optional = false; }
      { plugin = lualine-nvim; optional = false; }
      { plugin = bufferline-nvim; optional = false; }
      { plugin = transparent-nvim; optional = false; }
      { plugin = nvim-web-devicons; optional = false; }
      { plugin = vim-highlightedyank; optional = false; }
      { plugin = indent-blankline-nvim; optional = false; }

      { plugin = nvim-treesitter.withAllGrammars; optional = false; }
      { plugin = nvim-treesitter-textobjects; optional = false; }

      { plugin = copilot-lua; optional = false; }
      { plugin = CopilotChat-nvim; optional = false; }

      { plugin = aerial-nvim; optional = false; }
      { plugin = plenary-nvim; optional = false; }
      { plugin = telescope-nvim; optional = false; }
      { plugin = telescope-coc-nvim; optional = false; }
      { plugin = telescope-ultisnips-nvim; optional = false; }
      { plugin = telescope-fzf-native-nvim; optional = false; }
      { plugin = telescope-file-browser-nvim; optional = false; }

      { plugin = boole-nvim; optional = false; }
      { plugin = nvim-autopairs; optional = false; }
      { plugin = nvim-highlight-colors; optional = false; }

      { plugin = vimtex; optional = false; }
      { plugin = vim-nix; optional = false; }
      { plugin = ultisnips; optional = false; }
      { plugin = vim-markdown; optional = false; }

      { plugin = vim-repeat; optional = false; }
      { plugin = vim-rooter; optional = false; }
      { plugin = vim-surround; optional = false; }
      { plugin = ReplaceWithRegister; optional = false; }

      { plugin = vim-rhubarb; optional = false; }
      { plugin = vim-fugitive; optional = false; }
      { plugin = committia-vim; optional = false; }
      { plugin = gitsigns-nvim; optional = false; }
    ];
    extraConfig = ''
      ${builtins.readFile ./init.vim}
      '';
    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      '';
    withPython3 = true;
  };

}
