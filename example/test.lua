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
    update = update.message
  elseif (update.luagram == 'updateMessageEdited') then
    update = app.getMessage(update.chat_id, update.message_id)
  end
  if update.content.text and update.content.text.text:match('ping') then
    app.sendText(update.chat_id, update.id, "%{Hi I'm,b} a %{luagram,github.com/luagram/luagram}",'lg',true)
  end
end
local filter_update = {
  'updateNewMessage',
  'updateNewChannelMessage',
  'updateMessageEdited'
}
luagram.run(main,filter_update)

