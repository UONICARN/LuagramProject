#!/usr/bin/env lua5.3
os.execute('sudo rm -rf /usr/lib/x86_64-linux-gnu/lua/5.3/luagram.so')
os.execute('sudo rm -rf /usr/local/share/lua/5.3/luagram-client.lua')
local done_logo = [[
____
|  _ \  ___  _ __   ___
| | | |/ _ \| '_ \ / _ \
| |_| | (_) | | | |  __/
|____/ \___/|_| |_|\___|]]
local so_path_file = {
  '/usr',
  'lib',
  'x86_64-linux-gnu',
  'lua',
  '5.3',
  'luagram.so'
}
local luagram_client_path = {
  '/usr',
  'local',
  'share',
  'lua',
  '5.3',
  'luagram-client.lua'
}
function exists(file_path)
   local ok, err, code = os.rename(file_path, file_path)
   if not ok then
      if code == 13 then
         return true
      end
   end
   return ok, err
end
local function rem_and_create_dir(tab)
  os.remove(table.concat(tab, '/'))
  for folder = 1, 5 do
    local path = tab[1]
    for level = 2, folder do
      path = path ..'/'.. tab[level]
    end
    if not exists(path) then
      os.execute('sudo mkdir '..path)
    end
  end
end
if os.execute('unzip luagram.zip') then
  rem_and_create_dir(so_path_file)
  os.execute('sudo mv luagram.so ' .. table.concat(so_path_file, '/'))
  rem_and_create_dir(luagram_client_path)
  os.execute('sudo mv luagram-client.lua ' .. table.concat(luagram_client_path, '/'))
  os.execute('sudo rm -rf luagram.zip')
  if exists(table.concat(so_path_file, '/')) and exists(table.concat(luagram_client_path, '/')) then
    print('\27[35m '..done_logo..' \27[0m')
    os.execute('sudo rm -rf setup.lua')
  end
end
