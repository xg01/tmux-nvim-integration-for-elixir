# tmux-nvim-integration-for-elixir
A collection of APIs for Neovim to acheive interactive development with Elixir.  

This relies on [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for parsing the Elixir AST.  

## Features
- Start iex sessions
- Hot reload modules inferred from the Vim cursor

## Roadmap 
- [fzf.vim](https://github.com/junegunn/fzf.vim) integration 
- Transient paste buffers implemented with ramfs/tmpfs (Linux only)
