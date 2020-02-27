local luagram = require 'luagram-client'
local app = luagram.set_config{
  api_id = , --Forced
  session_name = 'Keyboard', --Forced
  api_hash = '', --Forced
}

--CallbackQuery function
function CallbackQuery(msg)
  if msg.payload then
    if msg.payload.data then
      data = app.base64_decode(msg.payload.data)
    end
    if data == 'luagram' then
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
      app.editMessageText(msg.chat_id,msg.message_id,'edit inline Keyboard Button\n\n' .. os.date('%T'), 'lg', true, false, reply_markup)
    end
  end
end
local filters_update = {
  'updateNewCallbackQuery'
}
app.run(CallbackQuery,filters_update)
