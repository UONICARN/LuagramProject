local luagram = require 'luagram-client'
local app = luagram.set_config{
  api_id = ,
  api_hash = '',
  session_name = '',
  token = ''
}
function main(update)
  if update.luagram == 'updateNewInlineQuery' then
    local results = {
      {
        type = 'article',
        id = '1',
        title = 'channel',
        description = 'telegram',
        reply_markup = {
              {
                {text = 'luagram channel', url = 't.me/luagramteam'}
              }
            },
        input = {
          type = 'text',
          text = "hello %{i'm luagram,b} \ncan i help you ??",
          parse_mode = 'lg'
        }
      },
      {
        type = 'article',
        id = '2',
        title = 'page',
        description = 'github',
        reply_markup = {
              {
                {text = 'github page', url = 'github.com/luagram/luagramProject'}
              }
            },
        input = {
          type = 'text',
          text = "hello %{i'm luagram,b} \ncan i help you ??",
          parse_mode = 'lg'
        }
      },
      {
        type = 'article',
        id = '3',
        title = 'share',
        description = 'telegram',
        reply_markup = {
              {
                {text = 'share', query = 'github.com/luagram/luagramProject'}
              }
            },
        input = {
          type = 'text',
          text = "hello %{i'm luagram,b} \ncan i help you ??",
          parse_mode = 'lg'
        }
      }
    }
    app.answerInlineQuery(update.id, results, '', 'luagram','switch_pm_parameter')
  end
end
luagram.run(main)

