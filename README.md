# tmux-nvim-integration-for-elixir
An attempt at emulating the human computer-interface of Lisp and Emacs/Slime with Elixir and Neovim/Tmux.

## Features
- Scripts for starting iex, similar to [npm scripts](https://docs.npmjs.com/cli/v8/using-npm/scripts)
- Hot reloading of modules in buffer


## Assumptions
This relies on [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for parsing the Elixir AST and [vim-slime](https://github.com/jpalardy/vim-slime) to send commands to Tmux.
