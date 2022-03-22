local api = vim.api
local buf, win 

local function open_window() 
  buf = api.nvim_create_buf(false, true)  -- create a new empty buffer

  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe') 

  -- dimensions
  function dimensions() 
    local width = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")
    return width, height
  end 

  local width, height = dimensions()

  -- compute floating window size
  local function floating_window_size() 
    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(height * 0.8) 
    return win_height, win_width
  end 

  local win_height, win_width = floating_window_size()

  -- compute floating window starting position
  local function centered_starting_position() 
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2) 
    return row, col
  end 

  local row, col = centered_starting_position() 

  -- window options
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  -- create window with buffer attached 
  win = api.nvim_open_win(buf, true, opts) 
end 


local function update_view() 
  local result = vim.fn.systemlist('ls') -- 'git diff-tree --no-commit-id --name-only -r HEAD'

  for k,v in pairs(result) do 
    result[k] = '  '..result[k]
  end 

  api.nvim_buf_set_lines(buf, 0, -1, false, result) 
end 

local position = 0

local function update_view(direction) 

  position = position + direction
  if position < 0 then position= 0 end  -- HEAD-0 is the newest state

  local result = vim.fn.systemlist('ls'..position)

  for k,v in pairs(result) do 
    result[k] = '  '..result[k]
  end 

  local function center(str) 
    local width = api.nvim_win_get_width(0)
    local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
    return string.rep(' ', shift) .. str 
  end 

  api.nvim_buf_set_lines(buf, 0, -1, false, { 
    center("lol"),
    center("ls'..position"),
  })

end
