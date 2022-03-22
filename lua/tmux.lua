local api = vim.api

tmux_cfg =  {
  socket_name = "default",
  target_pane =  ":",
  dont_ask_default = 1,
  cell_delimiter = "#%%"
}

local slime_paste_file = vim.fn.expand("$HOME/.slime_paste") -- replace this to in-memory fs

local function write_paste_file(text)
  vim.fn.system("cat > " .. slime_paste_file, text) -- Writes the output of cmd (first arg) to 
end 

local function tmux_command(socket, args)
  local socket = ""
  local socket_opt = ""  -- "-S" for (absolute) socket-path or "-L" for socket-name
  return vim.fn.system("tmux ".. socket_opt .. vim.fn.shellescape(socket) .. args) -- calls command and returns result as a string
end 

local function tmux_send(text) 
  write_paste_file(text) -- store text as a file in the in-memory fs 
  tmux_command("load-buffer " .. slime_paste_file) -- loads in-memory fs paste file into tmux paste buffer
  tmux_command("paste-buffer -d -p -t " .. vim.fn.shellescape("target_pane")) -- how to parameterize target pane? -d: delete pate buffer f rom stack  -p:L 
end 

local function tmux_pane_names() 
  local format = '#{pane_id} #{session_name}:#{window_index}.#{pane_index} #{window_name}#{?window_active, (active),}'
  tmux_command("list-panes -a -F" .. vim.fn.shellescape(format))
end 

local function get_buffer_number()
  return vim.fn.echo('bufnr('%')')
end


