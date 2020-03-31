<p align="center"><a href="https://t.me/Luagramteam"><img src="https://raw.githubusercontent.com/luagram/LuagramProject/master/luagram.png" width="300"src="">
</p>
L U A G R A M V-1.3
---
                                                            
<div align="center">

![](https://img.shields.io/github/forks/luagram/luagramproject.svg)
![](https://img.shields.io/github/stars/luagram/luagramproject.svg)
![](https://img.shields.io/github/issues/luagram/luagramproject.svg)
![](https://img.shields.io/badge/language-lua-yellow.svg)
![](https://img.shields.io/badge/license-MIT-informational.svg)
</div>

---

# [Telegram Channel and Group](https://t.me/LuaGramTeam)

# installing : lua = 5.3

git clone https://github.com/luagram/LuagramProject.git

cd LuagramProject

sudo lua5.3 setup.lua

## Using : 
- Import `luagram-client` into the bot.
- Call the functions.

See example script below.


```lua

local luagram = require 'luagram-client'
local app = luagram.set_config{
  encryption_key = '', --optional
  device_model = 'luagram', --optional
  system_version = 'linux', --optional
  language_code = 'en', --optional
  app_version = '1.0', --optional
  use_message_database = false, --optional
  use_secret_chats = true, --optional
  enable_storage_optimizer = true, --optional
  use_pfs = true, --optional
  api_id = api_id, --Forced
  session_name = '', --Forced
  api_hash = '' --Forced
}
function main(update)
  if update.message then
    local update = update.message
    if update.content.text  then
      if app.match('ping','luagram')[update.content.text.text] then
        app.sendText(update.chat_id, update.id, "%{Hi I'm,b} a %{luagram,github.com/luagram}",'lg',true)
      end
    end
  end
end
local filter_update = {
  'updateNewMessage',
  'updateNewChannelMessage'
}
luagram.run(main,filter_update)




```
for get result  

```lua 
result = app.FUNCTION()
app.vardump(result)
```
