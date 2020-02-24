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
      local reply_markup = {
        luagram = 'replyMarkupInlineKeyboard',
        rows = {
          {
            {
              luagram = 'inlineKeyboardButton',
              text = 'update',
              type = {
                data = app.base64_encode('luagram'), -- Base64 only
                luagram = 'inlineKeyboardButtonTypeCallback',
              }
            }
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
app.add_events(CallbackQuery,filters_update)

-- main script function
function main(update)
  if update.message then
    msg = update.message
    if msg.content.text then
      text = msg.content.text.text
      if text == '/start' then
        local reply_markup = {
          luagram = 'replyMarkupInlineKeyboard',
          rows = {
            {
              {
                luagram = 'inlineKeyboardButton',
                text = 'luagram',
                type = {
                  data = app.base64_encode('luagram'), -- Base64 only
                  luagram = 'inlineKeyboardButtonTypeCallback',
                }
              }
            },
            {
              {
                luagram = 'inlineKeyboardButton',
                text = 'group',
                type = {
                  url = 'https://t.me/joinchat/L9wvoFAFZcFRXEWsTtttYw',
                  luagram = 'inlineKeyboardButtonTypeUrl',
                }
              },
              {
                luagram = 'inlineKeyboardButton',
                text = 'channel',
                type = {
                  url = 't.me/LuaGramTeam',
                  luagram = 'inlineKeyboardButtonTypeUrl',
                }
              }
            },
            {
              {
                luagram = 'inlineKeyboardButton',
                text = 'github',
                type={
                  luagram = 'inlineKeyboardButtonTypeUrl',
                  url = 'https://github.com/luagram/luagramProject'
                }
              }
            }
          }
        }
        app.sendText(msg.chat_id, msg.id, "%{hello,b} i'm %{luagram,c}", 'lg', true, false, false, false, reply_markup)
      end
    end
  end
end
local filters_update = {
  'updateNewMessage',
  'updateNewChannelMessage'
}
luagram.run(main,filter_update)
