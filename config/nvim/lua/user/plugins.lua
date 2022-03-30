-- ██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗
-- ██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝
-- ██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████
-- ██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║
-- ██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║
-- ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝

-- Plugins & Packer Setup {{{
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    autocmd BufWinLeave plugins.lua mkview
    autocmd BufWinEnter plugins.lua loadview
  augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a pop up window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end
  },
}
--- }}}

return packer.startup(function(use)

    -- 🔧 Utility -------------------------------------------------------------
    use "wbthomason/packer.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    ---------------------------------------------------------------------------

    -- 🪄 Completion ----------------------------------------------------------
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-calc"
    use "hrsh7th/cmp-emoji"
    use "max397574/cmp-greek"
    use "saadparwaiz1/cmp_luasnip"
    ---------------------------------------------------------------------------

    -- 📚 LSP -----------------------------------------------------------------
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "tamago324/nlsp-settings.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    ---------------------------------------------------------------------------

    -- ✂️  Snippets ------------------------------------------------------------
    use "L3MON4D3/LuaSnip" -- TODO: expand on this
    use "rafamadriz/friendly-snippets"
    ---------------------------------------------------------------------------

    -- 🌲 Treesitter ----------------------------------------------------------
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use "nvim-treesitter/playground"
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'mfussenegger/nvim-ts-hint-textobject'
    use 'andymass/vim-matchup'
    use { 'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    }
    -- theHamsta/nvim-dap-virtual-text -- debugging
    -- SmiteshP/nvim-gps -- status line
    ---------------------------------------------------------------------------

    -- 🔭 Telescope -----------------------------------------------------------
    use "nvim-telescope/telescope.nvim"
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use "nvim-telescope/telescope-media-files.nvim"
    ---------------------------------------------------------------------------

    -- 👀 UI ------------------------------------------------------------------
    use "folke/tokyonight.nvim"
    use "itchyny/lightline.vim"
    use "kyazdani42/nvim-web-devicons"
    use "norcalli/nvim-colorizer.lua"
    ---------------------------------------------------------------------------

    -- ✋ UX ------------------------------------------------------------------
    use "iamcco/markdown-preview.nvim"
    ---------------------------------------------------------------------------

    -- REVIEW -----------------------------------------------------------------
    use "ThePrimeagen/harpoon"
    use "tpope/vim-commentary"
    use "tpope/vim-fugitive"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "mhinz/vim-startify"
    use "mhinz/vim-signify"
    use "easymotion/vim-easymotion"
    use "mattn/emmet-vim"
    use "mbbill/undotree"
    use "junegunn/vim-easy-align"
    ---------------------------------------------------------------------------

    -- MAYBE?
    -- nvim-notify

    -- Automatically set up configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
