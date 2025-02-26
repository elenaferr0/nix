{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.file = {
    ".local/share/nvim/site/pack/paks/start/visimp".source = pkgs.fetchFromGitHub {
      owner = "visimp";
      repo = "visimp";
      rev = "dd8d5d5a1ab74206f00c6d4fcef337ba9ee5b9ca"; # "v0.6.0";
      sha256 = "sha256-PlXasy9/HjUZcALtIYBYfM5y/g0XQfH8Vy4W2A5aJfU="; # lib.fakeSha256;
    };
  };

  # environment.variables.EDITOR = "nvim";
  programs.neovim = {
    enable = true;
    viAlias = true;
    defaultEditor = true;
    plugins = with pkgs; [
      vimPlugins.bufferline-nvim
      vimPlugins.lsp-colors-nvim
      vimPlugins.lsp-format-nvim
      vimPlugins.lualine-nvim
      vimPlugins.nvim-tree-lua
      vimPlugins.tabline-nvim
      vimPlugins.telescope-nvim
      vimPlugins.vim-repeat
      vimPlugins.vim-sneak
      vimPlugins.vim-surround
      # (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.c p.java ]))
    ];
    extraLuaConfig = ''

      vim.opt.relativenumber = true
      vim.opt.number = true
      vim.opt.colorcolumn = '0'
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.cmd("set splitbelow")

      -- buffer navigation
      vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>be', ':enew<CR>', { noremap = true })

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fm', builtin.marks, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      -- vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
      -- vim.api.nvim_set_keymap('n', '<leader>fn', ':Telescope notify<CR>', { noremap = true })

      -- local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
      -- vim.keymap.set('n', '<leader>fc', live_grep_args_shortcuts.grep_word_under_cursor)
      -- vim.keymap.set('n', '<leader>fs', live_grep_args_shortcuts.grep_visual_selection)

      require 'tabline'.setup({
        enable = true,
        options = {
          section_separators = { '', '' },
          component_separators = { '', '' },
          show_tabs_always = true,
          show_devicons = true,
          show_bufnr = true
        }
      })

      require 'visimp' {
        autopairs = {},
        lsp = {},
        lspsignature = {},
        lspformat = {},
        blankline = {},
        gitsigns = {},
        icons = {},
        languages = {
          -- 'c',
          -- 'java',
          -- 'javascript',
          -- 'json',
          -- 'python',
          -- 'lua',
          -- 'bash',
          -- 'typst'
        },
        nvimtree = {
          sort_by = "case_sensitive",
          view = {
            width = 30,
          },
          renderer = {
            group_empty = true,
            icons = {
              glyphs = {
                default = "",
                symlink = "",
                git = {
                  unstaged = "",
                  staged = "S",
                  unmerged = "",
                  renamed = "➜",
                  deleted = "",
                  untracked = "U",
                  ignored = "◌",
                },
                folder = {
                  -- arrow_open = " ",
                  -- arrow_closed = "",
                  default = "",
                  open = "",
                  empty = "",
                  empty_open = "",
                  symlink = "",
                },
              },
            }
          },
          hijack_directories = {
            enable = true,
            auto_open = true,
          },
          filters = {
            dotfiles = false,
          },
        },
        telescope = {
          pickers = {
            find_files = { theme = 'dropdown' }
          },
          builtin = {
            find_files = {
              theme = 'dropdown',
              hidden = true,
            },
            live_grep = {
              theme = 'dropdown',
            },
            buffers = {
              theme = 'dropdown',
            },
            help_tags = {
              theme = 'dropdown',
            },
          },
          load_extension = {
            notify = true,
          },
          defaults = {
            grep_hidden = true,
            file_ignore_patterns = {
              "%.7z",
              "%.JPEG",
              "%.JPG",
              "%.MOV",
              "%.RAF",
              "%.burp",
              "%.bz2",
              "%.cache",
              "%.class",
              "%.dll",
              "%.docx",
              "%.dylib",
              "%.epub",
              "%.exe",
              "%.flac",
              "%.ico",
              "%.ipynb",
              "%.jar",
              "%.jpeg",
              "%.jpg",
              "%.lock",
              "%.mkv",
              "%.mov",
              "%.mp4",
              "%.otf",
              "%.pdb",
              "%.pdf",
              "%.png",
              "%.rar",
              "%.sqlite3",
              "%.svg",
              "%.tar",
              "%.tar.gz",
              "%.ttf",
              "%.webp",
              "%.zip",
              ".git/",
              ".gradle/",
              ".idea/",
              ".settings/",
              ".vale/",
              ".vscode/",
              "__pycache__/*",
              "build/",
              "env/",
              "gradle/",
              "node_modules/",
              "smalljre_*/*",
              "target/",
              "vendor/*",
            }
          }
        }
      }
    '';
  };
}
