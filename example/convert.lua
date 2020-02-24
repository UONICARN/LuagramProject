local luagram = require 'luagram-client'
local app = luagram.set_config{
  api_id = api_id,
  session_name = 'convert',
  api_hash = 'api_hash'
}
function main(update)
  if update.message then
    local update = update.message
    if update.content.text then
      if string.lower(update.content.text.text) == '/tosticker' and update.reply_to_message_id ~= 0 then
        local result = app.getMessage(update.chat_id, update.reply_to_message_id)
        if result.content.photo then
          repeat
             download = app.downloadFile(result.content.photo.sizes[#result.content.photo.sizes].photo.id)
          until #download['local'].path ~= 0
           app.sendSticker(update.chat_id, update.id, download['local'].path, 512, 128)
         else
           app.sendText(update.chat_id, update.id, '%{Error !,b}\n%{Not photo message,c}','lg')
        end
      elseif string.lower(update.content.text.text) == '/tophoto' and update.reply_to_message_id ~= 0 then
        local result = app.getMessage(update.chat_id, update.reply_to_message_id)
        if result.content.sticker then
          repeat
             download = app.downloadFile(result.content.sticker.sticker.id)
          until #download['local'].path ~= 0
           app.sendPhoto(update.chat_id, update.id, download['local'].path)
         else
           app.sendText(update.chat_id, update.id, '%{Error !,b}\n%{Not sticker message,c}','lg')
        end
      end
    end
  end
end
local filter_update = {
  'updateNewMessage',
  'updateNewChannelMessage'
}
luagram.run(main,filter_update)
