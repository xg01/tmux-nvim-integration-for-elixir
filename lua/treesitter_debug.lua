-- load this with file :nmap <localleader>r :luafile debug.lua<CR>
local q = require"vim.treesitter.query"

local scripts = {
  iex = "iex -S mix"
}

local function i(value)
  print(vim.inspect(value))
end

local function get_cursor_position() 
  local s = require'nvim-treesitter'.statusline({
    indicator_size = 100,
    type_patterns = {"call"}
  })
  print(string.format("%s", s))
end

local function get_module_name()
  -- :h nvim_treesitter#statusline
  local cursor_position = nvim.treesitter.statusline()
  
  -- Replace ModuleNameHere with the name of the module you wish to query
  local module_name_query = vim.treesitter.parse_query('elixir', [[ 
    (call 
      (arguments 
        (alias) @module_name (#eq? @module_name "ModuleNameHere")))
  ]])

  local bufnr = vim.api.nvim_eval('bufnr("%")') 
  local language_tree = vim.treesitter.get_parser(bufnr, 'elixir')
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()

  for _, captures, metadata in module_name_query:iter_matches(root, bufnr) do 
      i(q.get_node_text(captures[1], bufnr)) -- i(captures)
  end
end

-- Sends a command to tmux start iex
local function iex()
  -- fixes: 
  -- 1. query from profile 
  -- 2. 
  local cmd = vim.api.nvim_exec(
  [[
    SlimeSend iex -S mix 
  ]]
  )
end

-- TODO: Integration with fzf.vim
local function fzf()
  -- local cmd = vim.api.nvim_exec(
  -- impl
  -- [[
  --   call fzf#run({'???', '???'))
  -- ]],
  -- true)
end
