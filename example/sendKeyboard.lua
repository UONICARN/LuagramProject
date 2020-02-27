local luagram = require 'luagram-client'
local app = luagram.set_config{
  session_name = '',
  api_id = ,
  api_hash = '',
  token = ''
}
function main(update)
  local update = update.message
  if update and update.content.text then
    if update.content.text.text == 'inline' then
      local reply_markup = app.replyMarkup{
        type = 'inline',
        data = {
          {
            {text = 'callback ', data = 'test'},
            {text = 'url ', url = 't.me'},
            {text = 'Switch ', query = 'hi'}, 
            --  inlineKeyboardButtonTypeLoginUrl {text = '', forward_text = '' , url = '' , id = } 
          }
        }
      }
      app.sendText(update.chat_id, update.id, 'replyMarkupInlineKeyboard', 'html', false, false, false, false, reply_markup)
    elseif update.content.text.text == 'keyboard' then
      local reply_markup = app.replyMarkup{
        type = 'keyboard',
        resize = true,
        is_personal = true,
        data = {
          {
            {text = 'location ', type = 'requestlocation'}, -- just private
            {text = 'phone ', type = 'requestphone'}, -- just private
            {text = 'poll ', type = 'requestpoll'}, -- just private
            {text = 'text ', type = 'text'},
          }
        }
      }
      app.sendText(update.chat_id, update.id, 'replyMarkupShowKeyboard', 'html', false, false, false, false, reply_markup)
    end
  end
end
luagram.run(main)
