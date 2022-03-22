# tmux-nvim-integration-for-elixir
A Neovim API to provide interactive development with Elixir.  

This relies on [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for parsing the Elixir AST and [vim-slime](https://github.com/jpalardy/vim-slime) to send commands to Tmux.

## Features
- Start iex sessions
- Hot reload modules inferred from the Vim cursor

## Roadmap 
- vim-fzf integration 
- Transient paste buffers implemented with ramfs/tmpfs (Linux only)
