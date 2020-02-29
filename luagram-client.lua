#!/usr/bin/env lua5.3
-- version 1.3
-- github.com/luagram
local luagram_function, function_core, update_functions, luagram_timer = {}, {}, {}, {}
local luagram = {
  get_update = true,
  logo = [[
 _     _   _    _       ____  ____      _     __  __
| |   | | | |  / \     / ___||  _ \    / \   |  \/  |
| |   | | | | / _ \   | |  _ | |_) |  / _ \  | |\/| |
| |___| |_| |/ ___ \  | |_| ||  _ <  / ___ \ | |  | |
|_____|\___//_/   \_\  \____||_| \_\/_/   \_\|_|  |_|

VERSION : 1.3 / BETA]],
luagram_helper = {
      ['match'] = ' function > app.match(table)[value]',
      ['base64_encode'] = ' function > app.base64_encode(str)',
      ['base64_decode'] = ' function > app.base64_decode(str)',
      ['number_format'] = ' function > app.number_format(number)',
      ['secToClock'] = ' function > app.secToClock(seconds)',
      ['in_array'] = ' function > app.in_array(table, value)',
      ['add_events'] = ' function > app.add_events(def,filters)',
      ['vardump'] = ' function > app.vardump(input)',
      ['set_timer'] = ' function > app.set_timer(seconds, def, argv)',
      ['get_timer'] = ' function > app.get_timer(timer_id)',
      ['cancel_timer'] = ' function > app.cancel_timer(timer_id)',
      ['exists'] = ' function > app.exists(file)',
      ['logOut'] = ' function > app.logOut()',
      ['getPasswordState'] = ' function > app.getPasswordState()',
      ['setPassword'] = ' function > app.setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)',
      ['getRecoveryEmailAddress'] = ' function > app.getRecoveryEmailAddress(password)',
      ['setRecoveryEmailAddress'] = ' function > app.setRecoveryEmailAddress(password, new_recovery_email_address)',
      ['requestPasswordRecovery'] = ' function > app.requestPasswordRecovery()',
      ['recoverPassword'] = ' function > app.recoverPassword(recovery_code)',
      ['createTemporaryPassword'] = ' function > app.createTemporaryPassword(password, valid_for)',
      ['getTemporaryPasswordState'] = ' function > app.getTemporaryPasswordState()',
      ['getMe'] = ' function > app.getMe()',
      ['getUser'] = ' function > app.getUser(user_id)',
      ['getUserFullInfo'] = ' function > app.getUserFullInfo(user_id)',
      ['getBasicGroup'] = ' function > app.getBasicGroup(basic_group_id)',
      ['getBasicGroupFullInfo'] = ' function > app.getBasicGroupFullInfo(basic_group_id)',
      ['getSupergroup'] = ' function > app.getSupergroup(supergroup_id)',
      ['getSupergroupFullInfo'] = ' function > app.getSupergroupFullInfo(supergroup_id)',
      ['getSecretChat'] = ' function > app.getSecretChat(secret_chat_id)',
      ['getChat'] = ' function > app.getChat(chat_id)',
      ['getMessage'] = ' function > app.getMessage(chat_id, message_id)',
      ['getRepliedMessage'] = ' function > app.getRepliedMessage(chat_id, message_id)',
      ['getChatPinnedMessage'] = ' function > app.getChatPinnedMessage(chat_id)',
      ['getMessages'] = ' function > app.getMessages(chat_id, message_ids)',
      ['getFile'] = ' function > app.getFile(file_id)',
      ['getRemoteFile'] = ' function > app.getRemoteFile(remote_file_id, file_type)',
      ['getChats'] = ' function > app.getChats(offset_chat_id, limit, offset_order)',
      ['searchPublicChat'] = ' function > app.searchPublicChat(username)',
      ['searchPublicChats'] = ' function > app.searchPublicChats(query)',
      ['searchChats'] = ' function > app.searchChats(query, limit)',
      ['checkChatUsername'] = ' function > app.checkChatUsername(chat_id, username)',
      ['searchChatsOnServer'] = ' function > app.searchChatsOnServer(query, limit)',
      ['clearRecentlyFoundChats'] = ' function > app.clearRecentlyFoundChats()',
      ['getTopChats'] = ' function > app.getTopChats(category, limit)',
      ['removeTopChat'] = ' function > app.removeTopChat(category, chat_id)',
      ['addRecentlyFoundChat'] = ' function > app.addRecentlyFoundChat(chat_id)',
      ['getCreatedPublicChats'] = ' function > app.getCreatedPublicChats()',
      ['setChatPermissions'] = ' function > app.setChatPermissions(chat_id, can_send_messages, can_send_media_messages, can_send_polls, can_send_other_messages, can_add_web_page_previews, can_change_info, can_invite_users, can_pin_messages)',
      ['removeRecentlyFoundChat'] = ' function > app.removeRecentlyFoundChat(chat_id)',
      ['getChatHistory'] = ' function > app.getChatHistory(chat_id, from_message_id, offset, limit, only_local)',
      ['getGroupsInCommon'] = ' function > app.getGroupsInCommon(user_id, offset_chat_id, limit)',
      ['searchMessages'] = ' function > app.searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)',
      ['searchChatMessages'] = ' function > app.searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)',
      ['searchSecretMessages'] = ' function > app.searchSecretMessages(chat_id, query, from_search_id, limit, filter)',
      ['deleteChatHistory'] = ' function > app.deleteChatHistory(chat_id, remove_from_chat_list)',
      ['searchCallMessages'] = ' function > app.searchCallMessages(from_message_id, limit, only_missed)',
      ['getChatMessageByDate'] = ' function > app.getChatMessageByDate(chat_id, date)',
      ['getPublicMessageLink'] = ' function > app.getPublicMessageLink(chat_id, message_id, for_album)',
      ['sendMessageAlbum'] = ' function > app.sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)',
      ['sendBotStartMessage'] = ' function > app.sendBotStartMessage(bot_user_id, chat_id, parameter)',
      ['sendInlineQueryResultMessage'] = ' function > app.sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)',
      ['forwardMessages'] = ' function > app.forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album)',
      ['sendChatSetTtlMessage'] = ' function > app.sendChatSetTtlMessage(chat_id, ttl)',
      ['sendChatScreenshotTakenNotification'] = ' function > app.sendChatScreenshotTakenNotification(chat_id)',
      ['deleteMessages'] = ' function > app.deleteMessages(chat_id, message_ids, revoke)',
      ['deleteChatMessagesFromUser'] = ' function > app.deleteChatMessagesFromUser(chat_id, user_id)',
      ['editMessageText'] = ' function > app.editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)',
      ['editMessageCaption'] = ' function > app.editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)',
      ['getTextEntities'] = ' function > app.getTextEntities(text)',
      ['getFileMimeType'] = ' function > app.getFileMimeType(file_name)',
      ['getFileExtension'] = ' function > app.getFileExtension(mime_type)',
      ['getInlineQueryResults'] = ' function > app.getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)',
      ['getCallbackQueryAnswer'] = ' function > app.getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)',
      ['deleteChatReplyMarkup'] = ' function > app.deleteChatReplyMarkup(chat_id, message_id)',
      ['sendChatAction'] = ' function > app.sendChatAction(chat_id, action, progress)',
      ['openChat'] = ' function > app.openChat(chat_id)',
      ['closeChat'] = ' function > app.closeChat(chat_id)',
      ['viewMessages'] = ' function > app.viewMessages(chat_id, message_ids, force_read)',
      ['openMessageContent'] = ' function > app.openMessageContent(chat_id, message_id)',
      ['readAllChatMentions'] = ' function > app.readAllChatMentions(chat_id)',
      ['createPrivateChat'] = ' function > app.createPrivateChat(user_id, force)',
      ['createBasicGroupChat'] = ' function > app.createBasicGroupChat(basic_group_id, force)',
      ['createSupergroupChat'] = ' function > app.createSupergroupChat(supergroup_id, force)',
      ['createSecretChat'] = ' function > app.createSecretChat(secret_chat_id)',
      ['createNewBasicGroupChat'] = ' function > app.createNewBasicGroupChat(user_ids, title)',
      ['createNewSupergroupChat'] = ' function > app.createNewSupergroupChat(title, is_channel, description)',
      ['createNewSecretChat'] = ' function > app.createNewSecretChat(user_id)',
      ['upgradeBasicGroupChatToSupergroupChat'] = ' function > app.upgradeBasicGroupChatToSupergroupChat(chat_id)',
      ['setChatTitle'] = ' function > app.setChatTitle(chat_id, title)',
      ['setChatPhoto'] = ' function > app.setChatPhoto(chat_id, photo)',
      ['setChatDraftMessage'] = ' function > app.setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)',
      ['toggleChatIsPinned'] = ' function > app.toggleChatIsPinned(chat_id, is_pinned)',
      ['setChatClientData'] = ' function > app.setChatClientData(chat_id, client_data)',
      ['addChatMember'] = ' function > app.addChatMember(chat_id, user_id, forward_limit)',
      ['addChatMembers'] = ' function > app.addChatMembers(chat_id, user_ids)',
      ['setChatMemberStatus'] = ' function > app.setChatMemberStatus(chat_id, user_id, status, right)',
      ['getChatMember'] = ' function > app.getChatMember(chat_id, user_id)',
      ['searchChatMembers'] = ' function > app.searchChatMembers(chat_id, query, limit)',
      ['getChatAdministrators'] = ' function > app.getChatAdministrators(chat_id)',
      ['setPinnedChats'] = ' function > app.setPinnedChats(chat_ids)',
      ['downloadFile'] = ' function > app.downloadFile(file_id, priority)',
      ['cancelDownloadFile'] = ' function > app.cancelDownloadFile(file_id, only_if_pending)',
      ['uploadFile'] = ' function > app.uploadFile(file, file_type, priority)',
      ['cancelUploadFile'] = ' function > app.cancelUploadFile(file_id)',
      ['deleteFile'] = ' function > app.deleteFile(file_id)',
      ['generateChatInviteLink'] = ' function > app.generateChatInviteLink(chat_id)',
      ['checkChatInviteLink'] = ' function > app.checkChatInviteLink(invite_link)',
      ['joinChatByInviteLink'] = ' function > app.joinChatByInviteLink(invite_link)',
      ['joinChatByUsernam'] = ' function > app.joinChatByUsernam(username)',
      ['createCall'] = ' function > app.createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)',
      ['acceptCall'] = ' function > app.acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)',
      ['blockUser'] = ' function > app.blockUser(user_id)',
      ['unblockUser'] = ' function > app.unblockUser(user_id)',
      ['getBlockedUsers'] = ' function > app.getBlockedUsers(offset, limit)',
      ['importContacts'] = ' function > app.importContacts(phone_number, first_name, last_name, user_id)',
      ['searchContacts'] = ' function > app.searchContacts(query, limit)',
      ['removeContacts'] = ' function > app.removeContacts(user_ids)',
      ['getImportedContactCount'] = ' function > app.getImportedContactCount()',
      ['changeImportedContacts'] = ' function > app.changeImportedContacts(phone_number, first_name, last_name, user_id)',
      ['clearImportedContacts'] = ' function > app.clearImportedContacts()',
      ['getUserProfilePhotos'] = ' function > app.getUserProfilePhotos(user_id, offset, limit)',
      ['getStickers'] = ' function > app.getStickers(emoji, limit)',
      ['searchStickers'] = ' function > app.searchStickers(emoji, limit)',
      ['getArchivedStickerSets'] = ' function > app.getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)',
      ['getTrendingStickerSets'] = ' function > app.getTrendingStickerSets()',
      ['getAttachedStickerSets'] = ' function > app.getAttachedStickerSets(file_id)',
      ['getStickerSet'] = ' function > app.getStickerSet(set_id)',
      ['searchStickerSet'] = ' function > app.searchStickerSet(name)',
      ['searchInstalledStickerSets'] = ' function > app.searchInstalledStickerSets(is_masks, query, limit)',
      ['searchStickerSets'] = ' function > app.searchStickerSets(query)',
      ['changeStickerSet'] = ' function > app.changeStickerSet(set_id, is_installed, is_archived)',
      ['viewTrendingStickerSets'] = ' function > app.viewTrendingStickerSets(sticker_set_ids)',
      ['reorderInstalledStickerSets'] = ' function > app.reorderInstalledStickerSets(is_masks, sticker_set_ids)',
      ['getRecentStickers'] = ' function > app.getRecentStickers(is_attached)',
      ['addRecentSticker'] = ' function > app.addRecentSticker(is_attached, sticker)',
      ['clearRecentStickers'] = ' function > app.clearRecentStickers(is_attached)',
      ['getFavoriteStickers'] = ' function > app.getFavoriteStickers()',
      ['addFavoriteSticker'] = ' function > app.addFavoriteSticker(sticker)',
      ['removeFavoriteSticker'] = ' function > app.removeFavoriteSticker(sticker)',
      ['getStickerEmojis'] = ' function > app.getStickerEmojis(sticker)',
      ['getSavedAnimations'] = ' function > app.getSavedAnimations()',
      ['addSavedAnimation'] = ' function > app.addSavedAnimation(animation)',
      ['removeSavedAnimation'] = ' function > app.removeSavedAnimation(animation)',
      ['getRecentInlineBots'] = ' function > app.getRecentInlineBots()',
      ['searchHashtags'] = ' function > app.searchHashtags(prefix, limit)',
      ['removeRecentHashtag'] = ' function > app.removeRecentHashtag(hashtag)',
      ['getWebPagePreview'] = ' function > app.getWebPagePreview(text)',
      ['getWebPageInstantView'] = ' function > app.getWebPageInstantView(url, force_full)',
      ['getNotificationSettings'] = ' function > app.getNotificationSettings(scope, chat_id)',
      ['setNotificationSettings'] = ' function > app.setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)',
      ['resetAllNotificationSettings'] = ' function > app.resetAllNotificationSettings()',
      ['setProfilePhoto'] = ' function > app.setProfilePhoto(photo)',
      ['deleteProfilePhoto'] = ' function > app.deleteProfilePhoto(profile_photo_id)',
      ['setName'] = ' function > app.setName(first_name, last_name)',
      ['setBio'] = ' function > app.setBio(bio)',
      ['setUsername'] = ' function > app.setUsername(username)',
      ['getActiveSessions'] = ' function > app.getActiveSessions()',
      ['terminateAllOtherSessions'] = ' function > app.terminateAllOtherSessions()',
      ['terminateSession'] = ' function > app.terminateSession(session_id)',
      ['toggleBasicGroupAdministrators'] = ' function > app.toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)',
      ['setSupergroupUsername'] = ' function > app.setSupergroupUsername(supergroup_id, username)',
      ['setSupergroupStickerSet'] = ' function > app.setSupergroupStickerSet(supergroup_id, sticker_set_id)',
      ['toggleSupergroupInvites'] = ' function > app.toggleSupergroupInvites(supergroup_id, anyone_can_invite)',
      ['toggleSupergroupSignMessages'] = ' function > app.toggleSupergroupSignMessages(supergroup_id, sign_messages)',
      ['toggleSupergroupIsAllHistoryAvailable'] = ' function > app.toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)',
      ['setChatDescription'] = ' function > app.setChatDescription(supergroup_id, description)',
      ['pinChatMessage'] = ' function > app.pinChatMessage(supergroup_id, message_id, disable_notification)',
      ['unpinChatMessage'] = ' function > app.unpinChatMessage(supergroup_id)',
      ['reportSupergroupSpam'] = ' function > app.reportSupergroupSpam(supergroup_id, user_id, message_ids)',
      ['getSupergroupMembers'] = ' function > app.getSupergroupMembers(supergroup_id, filter, query, offset, limit)',
      ['deleteSupergroup'] = ' function > app.deleteSupergroup(supergroup_id)',
      ['closeSecretChat'] = ' function > app.closeSecretChat(secret_chat_id)',
      ['getChatEventLog'] = ' function > app.getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)',
      ['getSavedOrderInfo'] = ' function > app.getSavedOrderInfo()',
      ['deleteSavedOrderInfo'] = ' function > app.deleteSavedOrderInfo()',
      ['deleteSavedCredentials'] = ' function > app.deleteSavedCredentials()',
      ['getSupportUser'] = ' function > app.getSupportUser()',
      ['getWallpapers'] = ' function > app.getWallpapers()',
      ['setUserPrivacySettingRules'] = ' function > app.setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)',
      ['getUserPrivacySettingRules'] = ' function > app.getUserPrivacySettingRules(setting)',
      ['getOption'] = ' function > app.getOption(name)',
      ['setOption'] = ' function > app.setOption(name, option_value, value)',
      ['setAccountTtl'] = ' function > app.setAccountTtl(ttl)',
      ['getAccountTtl'] = ' function > app.getAccountTtl()',
      ['deleteAccount'] = ' function > app.deleteAccount(reason)',
      ['getChatReportSpamState'] = ' function > app.getChatReportSpamState(chat_id)',
      ['reportChat'] = ' function > app.reportChat(chat_id, reason, text, message_ids)',
      ['getStorageStatistics'] = ' function > app.getStorageStatistics(chat_limit)',
      ['getStorageStatisticsFast'] = ' function > app.getStorageStatisticsFast()',
      ['optimizeStorage'] = ' function > app.optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)',
      ['setNetworkType'] = ' function > app.setNetworkType(type)',
      ['getNetworkStatistics'] = ' function > app.getNetworkStatistics(only_current)',
      ['addNetworkStatistics'] = ' function > app.addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)',
      ['resetNetworkStatistics'] = ' function > app.resetNetworkStatistics()',
      ['getCountryCode'] = ' function > app.getCountryCode()',
      ['getInviteText'] = ' function > app.getInviteText()',
      ['getTermsOfService'] = ' function > app.getTermsOfService()',
      ['sendText'] = ' function > app.sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)',
      ['sendAnimation'] = ' function > app.sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendAudio'] = ' function > app.sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendDocument'] = ' function > app.sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendPhoto'] = ' function > app.sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendSticker'] = ' function > app.sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)',
      ['sendVideo'] = ' function > app.sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendVideoNote'] = ' function > app.sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendVoiceNote'] = ' function > app.sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)',
      ['sendLocation'] = ' function > app.sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)',
      ['sendVenue'] = ' function > app.sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)',
      ['sendContact'] = ' function > app.sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)',
      ['sendInvoice'] = ' function > app.sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)',
      ['sendForwarded'] = ' function > app.sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)',
      ['sendPoll'] = ' function > app.sendPoll(chat_id, reply_to_message_id, question, options, pollType, is_anonymous, allow_multiple_answers)',
      ['addProxy'] = ' function > app.addProxy(proxy_type, server, port, username, password_secret, http_only)',
      ['enableProxy'] = ' function > app.enableProxy(proxy_id)',
      ['pingProxy'] = ' function > app.pingProxy(proxy_id)',
      ['disableProxy'] = ' function > app.disableProxy(proxy_id)',
      ['getProxies'] = ' function > app.getProxies()',
      ['answerCallbackQuery'] = ' function > app.answerCallbackQuery(callback_query_id, text, show_alert, url, cache_time)',
      ['leaveChat'] = ' function > app.leaveChat(chat_id)',
      ['replyMarkup'] = ' function > app.replyMarkup(input)',
      ['getPollVoters'] = ' function > app.getPollVoters(chat_id, message_id, option_id, offset, limit)',
      ['setPollAnswer'] = ' function > app.setPollAnswer(chat_id, message_id, option_ids)',
      ['len'] = ' function > app.len(value)',
      ['answerInlineQuery'] = ' function > app.answerInlineQuery(inline_query_id, results, next_offset, switch_pm_text, switch_pm_parameter, is_personal, cache_time)'
},
colors_key = {
  reset =      0,
  bright     = 1,
  dim        = 2,
  underline  = 4,
  blink      = 5,
  reverse    = 7,
  hidden     = 8,
  black     = 30,
  red       = 31,
  green     = 32,
  yellow    = 33,
  blue      = 34,
  magenta   = 35,
  cyan      = 36,
  white     = 37,
  blackbg   = 40,
  redbg     = 41,
  greenbg   = 42,
  yellowbg  = 43,
  bluebg    = 44,
  magentabg = 45,
  cyanbg    = 46,
  whitebg   = 47
},
  config = {
  }
}
local LuaGram = require 'luagram'
local client = LuaGram()
----------------------------------------------- luagram core function
function function_core._CALL_(update)
  if update and type(update) == 'table' then
    for i = 0 , #update_functions do
      if not update_functions[i].filters then
        send_update = true
        update_message = update
      elseif update.luagram and update_functions[i].filters and luagram_function.in_array(update_functions[i].filters,  update.luagram) then
        send_update = true
        update_message = update
      else
        send_update = false
      end
      if update_message and send_update and type(update_message) == 'table' then
        xpcall(update_functions[i].def, function_core.print_error, update_message)
      end
      update_message = nil
      send_update = nil
    end
  end
end
function function_core.change_table(input, send)
  if send then
    changes ={
      luagram = string.reverse('epyt@')
    }
    rems = {
    }
  else
    changes = {
      _ = string.reverse('margaul'),
    }
    rems = {
      string.reverse('epyt@')
    }
  end
  if type(input) == 'table' then
    local res = {}
    for key,value in pairs(input) do
      for k, rem in pairs(rems) do
        if key == rem then
          value = nil
        end
      end
      local key = changes[key] or key
      if type(value) ~= 'table' then
        res[key] = value
      else
        res[key] = function_core.change_table(value, send)
      end
    end
    return res
  else
    return input
  end
end
function function_core.run_table(input)
  local to_original = function_core.change_table(input, true)
  local result = client:execute(to_original)
  if type(result) ~= 'table' then
    return nil
  else
    return function_core.change_table(result)
  end
end
function function_core.print_error(err)
  print(luagram_function.colors('%{red}\27[5m bug in your script ! %{reset}\n\n%{red}'.. err))
end
function function_core.send_tdlib(input)
  local to_original = function_core.change_table(input, true)
  client:send(to_original)
end

function_core.send_tdlib{
  luagram = 'getAuthorizationState'
}
LuaGram.setLogLevel(3)
LuaGram.setLogPath('/usr/lib/x86_64-linux-gnu/lua/5.3/.luagram.log')
-----------------------------------------------luagram_function
function luagram_function.len(input)
  if type(input) == 'table' then
    size = 0
    for key,value in pairs(input) do
      size = size + 1
    end
    return size
  else
    size = tostring(input)
    return #size
  end
end
function luagram_function.match(...)
  local val = {}
  for no,v in ipairs({...}) do
    val[v] = true
  end
  return val
end
function luagram_function.poll(chat_id)
  return function_core.run_table{
      luagram = 'sendMessage',
      chat_id = chat_id,
      reply_to_message_id = reply_to_message_id or 0,
      input_message_content = {
        luagram = 'inputMessagePoll',
        is_anonymous = true,
        question = 'test',
        type = {
          luagram = 'pollTypeRegular',
          allow_multiple_answers = false
        },
        options = {'t','test2'}
    }
  }
end
function luagram_function.secToClock(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return {hours=00,mins=00,secs=00}
  else
    local hours = string.format("%02.f", math.floor(seconds / 3600));
    local mins = string.format("%02.f", math.floor(seconds / 60 - ( hours*60 ) ));
    local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
    return {hours=hours,mins=mins,secs=secs}
  end
end
function luagram_function.number_format(num)
  local out = tonumber(num)
  while true do
    out,i= string.gsub(out,'^(-?%d+)(%d%d%d)', '%1,%2')
    if (i==0) then
      break
    end
  end
  return out
end
function luagram_function.base64_encode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((str:gsub('.', function(x)
			local r,Base='',x:byte()
			for i=8,1,-1 do r=r..(Base%2^i-Base%2^(i-1)>0 and '1' or '0') end
			return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return Base:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#str%3+1])
end
function luagram_function.base64_decode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  str = string.gsub(str, '[^'..Base..'=]', '')
  return (str:gsub('.', function(x)
    if (x == '=') then
      return ''
    end
    local r,f='',(Base:find(x)-1)
    for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then
      return ''
    end
    local c=0
    for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
    return string.char(c)
  end))
end
function luagram_function.exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         return true
      end
   end
   return ok, err
end
function luagram_function.in_array(table, value)
  for k,v in pairs(table) do
    if value == v then
      return true
    end
  end
  return false
end
function luagram_function.colors(buffer)
  for keys in buffer:gmatch('%%{(.-)}') do
    buffer = string.gsub(buffer,'%%{'..keys..'}', '\27['..luagram.colors_key[keys]..'m')
  end
  return buffer .. '\27[0m'
end
function luagram_function.add_events(def,filters)
  if type(def) ~= 'function' then
    function_core.print_error('the add_events def must be a function !')
    return {
      luagram = false,
    }
    elseif type(filters) ~= 'table' then
      function_core.print_error('the add_events filters must be a table !')
      return {
        luagram = false,
      }
    else
      local function_id = #update_functions + 1
      update_functions[function_id] = {}
      update_functions[function_id].def = def
      update_functions[function_id].filters = filters
      return {
        luagram = true,
      }
  end
end
function luagram_function.help(def_name)
  if not def_name or def_name == '*' then
    local Counter = 0
    print(luagram_function.colors('%{green} luagram function name :%{reset} \n\n'))
    for function_name,example in pairs(luagram.luagram_helper) do
      if Counter % 2 == 0 then
        print(luagram_function.colors(Counter..' - %{yellow}'..function_name..'%{reset}'))
      else
        print(Counter..' - '..function_name)
      end
      Counter = Counter + 1
    end
    print(luagram_function.colors('\n\n%{green} > app.help(function_name)'))
  elseif def_name then
    for key,value in pairs(luagram.luagram_helper) do
      if string.lower(def_name) == string.lower(key) then
        print(luagram_function.colors(' - %{yellow} '..value))
        return value
      end
    end
  else
    print(luagram_function.colors(' - %{red} Function not found ! %{reset}'))
  end
end
function luagram_function.vardump(input)
  local function vardump(value)
     if type(value) == 'table' then
        local dump = '{\n'
        for key,v in pairs(value) do
           if type(key) == 'number' then
             key = '['..key..']'
           elseif type(key) == 'string' and key:match('@') then
             key = '["'..key..'"]'
           end
           if type(v) == 'string' then
             v = "'" .. v .. "'"
           end
           dump = dump .. key .. ' = ' .. vardump(v) .. ',\n'
        end
        return dump .. '}'
     else
        return tostring(value)
     end
   end
  print(luagram_function.colors('%{yellow} vardump : %{reset}\n\n%{green}'..vardump(input)))
  return vardump(input)
end
function luagram_function.set_timer(seconds, def, argv)
  if type(seconds) ~= 'number' then
    return {
      luagram = false,
      message = 'set_timer(int seconds, funtion def, table)'
    }
  elseif type(def) ~= 'function' then
    return {
      luagram = false,
      message = 'set_timer(int seconds, funtion def, table)'
    }
  end
  luagram_timer[#luagram_timer + 1] = {
    def = def,
    argv = argv,
    run_in = os.time() + seconds
  }
  return {
    luagram = true,
    run_in = os.time() + seconds,
    timer_id = #luagram_timer
  }
end
function luagram_function.get_timer(timer_id)
  local timer_data = luagram_timer[timer_id]
  if timer_data then
    return {
      luagram = true,
      run_in = timer_data.run_in,
      argv = timer_data.argv
    }
  else
    return {
      luagram = false,
    }
  end
end
function luagram_function.cancel_timer(timer_id)
  if luagram_timer[timer_id] then
    table.remove(luagram_timer,timer_id)
    return {
      luagram = true
    }
  else
    return {
      luagram = false
    }
  end
end

function luagram_function.replyMarkup(input)
  if type(input.type) ~= 'string' then
    return nil
  end
  local _type = string.lower(input.type)
  if _type == 'inline' then
    local result = {
      luagram = 'replyMarkupInlineKeyboard',
      rows = {
      }
    }
    for _, rows in pairs(input.data) do
      local new_id = #result.rows + 1
      result.rows[new_id] = {}
      for key, value in pairs(rows) do
        local rows_new_id = #result.rows[new_id] + 1
        if value.url and value.text then
          result.rows[new_id][rows_new_id] = {
            luagram = 'inlineKeyboardButton',
            text = value.text,
            type = {
              luagram = 'inlineKeyboardButtonTypeUrl',
              url = value.url
            }
          }
        elseif value.data and value.text then
            result.rows[new_id][rows_new_id] = {
              luagram = 'inlineKeyboardButton',
              text = value.text,
              type = {
                data = luagram_function.base64_encode(value.data), -- Base64 only
                luagram = 'inlineKeyboardButtonTypeCallback',
              }
            }
          elseif value.forward_text and value.id and value.url and value.text then
            result.rows[new_id][rows_new_id] = {
              luagram = 'inlineKeyboardButton',
              text = value.text,
              type = {
                id = value.id,
                url = value.url,
                forward_text = value.forward_text,
                luagram = 'inlineKeyboardButtonTypeLoginUrl',
              }
            }
          elseif value.query and value.text then
            result.rows[new_id][rows_new_id] = {
              luagram = 'inlineKeyboardButton',
              text = value.text,
              type = {
                query = value.query,
                luagram = 'inlineKeyboardButtonTypeSwitchInline',
              }
            }
        end
      end
    end
    return result
  elseif _type == 'keyboard' then
    local result = {
      luagram = 'replyMarkupShowKeyboard',
      resize_keyboard = input.resize,
      one_time = input.one_time,
      is_personal = input.is_personal,
      rows = {
      }
    }
    for _, rows in pairs(input.data) do
      local new_id = #result.rows + 1
      result.rows[new_id] = {}
      for key, value in pairs(rows) do
        local rows_new_id = #result.rows[new_id] + 1
        if type(value.type) == 'string' then
          value.type = string.lower(value.type)
          if value.type == 'requestlocation' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                luagram = 'keyboardButtonTypeRequestLocation'
              },
              luagram = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'requestphone' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                luagram = 'keyboardButtonTypeRequestPhoneNumber'
              },
              luagram = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'requestpoll' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                luagram = 'keyboardButtonTypeRequestPoll',
                force_regular = value.force_regular,
                force_quiz = value.force_quiz
              },
              luagram = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'text' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                luagram = 'keyboardButtonTypeText'
              },
              luagram = 'keyboardButton',
              text = value.text
            }
          end
        end
      end
    end
    return result
  elseif _type == 'forcereply' then
    return {
      luagram = 'replyMarkupForceReply',
      is_personal = input.is_personal
    }
  elseif _type == 'remove' then
    return {
      luagram = 'replyMarkupRemoveKeyboard',
      is_personal = input.is_personal
    }
  end
end
function luagram_function.addProxy(proxy_type, server, port, username, password_secret, http_only)
  if type(proxy_type) ~= 'string' then
    return {
    luagram = false
    }
  end
  local proxy_type = string.lower(proxy_type)
  if proxy_type == 'mtproto' then
    _type_ = {
      luagram = 'proxyTypeMtproto',
      secret = password_secret
    }
  elseif proxy_Type == 'socks5' then
    _type_ = {
      luagram = 'proxyTypeSocks5',
      username = username,
      password = password_secret
    }
  elseif proxy_Type == 'http' then
    _type_ = {
      luagram = 'proxyTypeHttp',
      username = username,
      password = password_secret,
      http_only = http_only
    }
  else
    return {
      luagram = false
    }
  end
  return function_core.run_table{
    luagram = 'addProxy',
    server = server,
    port = port,
    type = _type_
  }
end
function luagram_function.enableProxy(proxy_id)
  return function_core.run_table{
   luagram = 'enableProxy',
    proxy_id = proxy_id
  }
end
function luagram_function.pingProxy(proxy_id)
  return function_core.run_table{
   luagram = 'pingProxy',
    proxy_id = proxy_id
  }
end
function luagram_function.disableProxy(proxy_id)
  return function_core.run_table{
   luagram = 'disableProxy',
    proxy_id = proxy_id
  }
end
function luagram_function.getProxies()
  return function_core.run_table{
    luagram = 'getProxies'
  }
end
function luagram_function.getChatId(chat_id)
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    return {
      id = string.sub(chat_id, 5),
      type = 'supergroup'
    }
  else
    local basicgroup_id = string.sub(chat_id, 2)
    return {
      id = string.sub(chat_id, 2),
      type = 'basicgroup'
    }
  end
end
function luagram_function.getInputFile(file, conversion_str, expected_size)
  local str = tostring(file)
  if (conversion_str and expectedsize) then
    return {
      luagram = 'inputFileGenerated',
      original_path = tostring(file),
      conversion = tostring(conversion_str),
      expected_size = expected_size
    }
  else
    if str:match('/') then
      return {
        luagram = 'inputFileLocal',
        path = file
      }
    elseif str:match('^%d+$') then
      return {
        luagram = 'inputFileId',
        id = file
      }
    else
      return {
        luagram = 'inputFileRemote',
        id = file
      }
    end
  end
end
function luagram_function.getParseMode(parse_mode)
  if parse_mode then
    local mode = parse_mode:lower()
    if mode == 'markdown' or mode == 'md' then
      return {
        luagram = 'textParseModeMarkdown'
      }
    elseif mode == 'html' or mode == 'lg' then
      return {
        luagram = 'textParseModeHTML'
      }
    end
  end
end
function luagram_function.parseTextEntities(text, parse_mode)
  if type(parse_mode) == 'string' and string.lower(parse_mode) == 'lg' then
    for txt in text:gmatch('%%{(.-)}') do
      local _text, text_type = txt:match('(.*),(.*)')
      local txt = string.gsub(txt,'+','++')
      local text_type = string.gsub(text_type,' ','')
      if type(_text) == 'string' and type(text_type) == 'string' then
        for key, value in pairs({['<'] = '&lt;',['>'] = '&gt;'}) do
          _text = string.gsub(_text, key, value)
        end
        if (string.lower(text_type) == 'b' or string.lower(text_type) == 'i' or string.lower(text_type) == 'c') then
          local text_type = string.lower(text_type)
          local text_type = text_type == 'c' and 'code' or text_type
          text = string.gsub(text,'%%{'..txt..'}','<'..text_type..'>'.._text..'</'..text_type..'>')
        else
          if type(tonumber(text_type)) == 'number' then
            link = 'tg://user?id='..text_type
          else
            link = text_type
          end
          text = string.gsub(text, '%%{'..txt..'}', '<a href="'..link..'">'.._text..'</a>')
        end
      end
    end
  end
  return function_core.run_table{
    luagram = 'parseTextEntities',
    text = tostring(text),
    parse_mode = luagram_function.getParseMode(parse_mode)
  }
end
function luagram_function.vectorize(table)
  if type(table) == 'table' then
    return table
  else
    return {
      table
    }
  end
end
function luagram_function.setLimit(limit, num)
  local limit = tonumber(limit)
  local number = tonumber(num or limit)
  return (number >= limit) and limit or number
end
function luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
  local luagram_body, message = {
    luagram = 'sendMessage',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id or 0,
    disable_notification = disable_notification or 0,
    from_background = from_background or 1,
    reply_markup = reply_markup,
    input_message_content = input_message_content
  }, {}
  if input_message_content.text then
    text = input_message_content.text.text
  elseif input_message_content.caption then
    text = input_message_content.caption.text
  end
  if text then
    if parse_mode then
      local result = luagram_function.parseTextEntities(text, parse_mode)
      if luagram_body.input_message_content.text then
        luagram_body.input_message_content.text = result
      else
        luagram_body.input_message_content.caption = result
      end
      return function_core.run_table(luagram_body)
    else
      while #text > 4096 do
        text = string.sub(text, 4096, #text)
        message[#message + 1] = text
      end
      message[#message + 1] = text
      for i = 1, #message do
        if input_message_content.text and input_message_content.text.text then
          luagram_body.input_message_content.text.text = message[i]
        elseif input_message_content.caption and input_message_content.caption.text then
          luagram_body.input_message_content.caption.text = message[i]
        end
        return function_core.run_table(luagram_body)
      end
    end
  else
    return function_core.run_table(luagram_body)
  end
end
function luagram_function.logOut()
  return function_core.run_table{
    luagram = 'logOut'
  }
end
function luagram_function.getPasswordState()
  return function_core.run_table{
    luagram = 'getPasswordState'
  }
end
function luagram_function.setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)
  return function_core.run_table{
    old_password = tostring(old_password),
    new_password = tostring(new_password),
    new_hint = tostring(new_hint),
    set_recovery_email_address = set_recovery_email_address,
    new_recovery_email_address = tostring(new_recovery_email_address)
  }
end
function luagram_function.getRecoveryEmailAddress(password)
  return function_core.run_table{
    luagram = 'getRecoveryEmailAddress',
    password = tostring(password)
  }
end
function luagram_function.setRecoveryEmailAddress(password, new_recovery_email_address)
  return function_core.run_table{
    luagram = 'setRecoveryEmailAddress',
    password = tostring(password),
    new_recovery_email_address = tostring(new_recovery_email_address)
  }
end
function luagram_function.requestPasswordRecovery()
  return function_core.run_table{
    luagram = 'requestPasswordRecovery'
  }
end
function luagram_function.recoverPassword(recovery_code)
  return function_core.run_table{
    luagram = 'recoverPassword',
    recovery_code = tostring(recovery_code)
  }
end
function luagram_function.createTemporaryPassword(password, valid_for)
  local valid_for = valid_for > 86400 and 86400 or valid_for
  return function_core.run_table{
    luagram = 'createTemporaryPassword',
    password = tostring(password),
    valid_for = valid_for
  }
end
function luagram_function.getTemporaryPasswordState()
  return function_core.run_table{
    luagram = 'getTemporaryPasswordState'
  }
end
function luagram_function.getMe()
  return function_core.run_table{
    luagram = 'getMe'
  }
end
function luagram_function.getUser(user_id)
  return function_core.run_table{
    luagram = 'getUser',
    user_id = user_id
  }
end
function luagram_function.getUserFullInfo(user_id)
  return function_core.run_table{
    luagram = 'getUserFullInfo',
    user_id = user_id
  }
end
function luagram_function.getBasicGroup(basic_group_id)
  return function_core.run_table{
    luagram = 'getBasicGroup',
    basic_group_id = luagram_function.getChatId(basic_group_id).id
  }
end
function luagram_function.getBasicGroupFullInfo(basic_group_id)
  return function_core.run_table{
    luagram = 'getBasicGroupFullInfo',
    basic_group_id = luagram_function.getChatId(basic_group_id).id
  }
end
function luagram_function.getSupergroup(supergroup_id)
  return function_core.run_table{
    luagram = 'getSupergroup',
    supergroup_id = luagram_function.getChatId(supergroup_id).id
  }
end
function luagram_function.getSupergroupFullInfo(supergroup_id)
  return function_core.run_table{
    luagram = 'getSupergroupFullInfo',
    supergroup_id = luagram_function.getChatId(supergroup_id).id
  }
end
function luagram_function.getSecretChat(secret_chat_id)
  return function_core.run_table{
    luagram = 'getSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function luagram_function.getChat(chat_id)
  return function_core.run_table{
    luagram = 'getChat',
    chat_id = chat_id
  }
end
function luagram_function.getMessage(chat_id, message_id)
  return function_core.run_table{
    luagram = 'getMessage',
    chat_id = chat_id,
    message_id = message_id
  }
end
function luagram_function.getRepliedMessage(chat_id, message_id)
  return function_core.run_table{
    luagram = 'getRepliedMessage',
    chat_id = chat_id,
    message_id = message_id
  }
end
function luagram_function.getChatPinnedMessage(chat_id)
  return function_core.run_table{
    luagram = 'getChatPinnedMessage',
    chat_id = chat_id
  }
end
function luagram_function.getMessages(chat_id, message_ids)
  return function_core.run_table{
    luagram = 'getMessages',
    chat_id = chat_id,
    message_ids = vectorize(message_ids)
  }
end
function luagram_function.getFile(file_id)
  return function_core.run_table{
    luagram = 'getFile',
    file_id = file_id
  }
end
function luagram_function.getRemoteFile(remote_file_id, file_type)
  return function_core.run_table{
    luagram = 'getRemoteFile',
    remote_file_id = tostring(remote_file_id),
    file_type = {
      luagram = 'fileType' .. file_type or 'Unknown'
    }
  }
end
function luagram_function.getChats(offset_chat_id, limit, offset_order)
  return function_core.run_table{
    luagram = 'getChats',
    offset_order = offset_order or '9223372036854775807',
    offset_chat_id = offset_chat_id or 0,
    limit = limit or 20
  }
end
function luagram_function.searchPublicChat(username)
  return function_core.run_table{
    luagram = 'searchPublicChat',
    username = tostring(username)
  }
end
function luagram_function.searchPublicChats(query)
  return function_core.run_table{
    luagram = 'searchPublicChats',
    query = tostring(query)
  }
end
function luagram_function.searchChats(query, limit)
  return function_core.run_table{
    luagram = 'searchChats',
    query = tostring(query),
    limit = limit
  }
end
function luagram_function.checkChatUsername(chat_id, username)
  return function_core.run_table{
    luagram = 'checkChatUsername',
    chat_id = chat_id,
    username = tostring(username)
  }
end
function luagram_function.searchChatsOnServer(query, limit)
  return function_core.run_table{
    luagram = 'searchChatsOnServer',
    query = tostring(query),
    limit = limit
  }
end
function luagram_function.clearRecentlyFoundChats()
  return function_core.run_table{
    luagram = 'clearRecentlyFoundChats'
  }
end
function luagram_function.getTopChats(category, limit)
  return function_core.run_table{
    luagram = 'getTopChats',
    category = {
      luagram = 'topChatCategory' .. category
    },
    limit = luagram_function.setLimit(30, limit)
  }
end
function luagram_function.removeTopChat(category, chat_id)
  return function_core.run_table{
    luagram = 'removeTopChat',
    category = {
      luagram = 'topChatCategory' .. category
    },
    chat_id = chat_id
  }
end
function luagram_function.addRecentlyFoundChat(chat_id)
  return function_core.run_table{
    luagram = 'addRecentlyFoundChat',
    chat_id = chat_id
  }
end
function luagram_function.getCreatedPublicChats()
  return function_core.run_table{
    luagram = 'getCreatedPublicChats'
  }
end
function luagram_function.removeRecentlyFoundChat(chat_id)
  return function_core.run_table{
    luagram = 'removeRecentlyFoundChat',
    chat_id = chat_id
  }
end
function luagram_function.getChatHistory(chat_id, from_message_id, offset, limit, only_local)
  return function_core.run_table{
    luagram = 'getChatHistory',
    chat_id = chat_id,
    from_message_id = from_message_id,
    offset = offset,
    limit = luagram_function.setLimit(100, limit),
    only_local = only_local
  }
end
function luagram_function.getGroupsInCommon(user_id, offset_chat_id, limit)
  return function_core.run_table{
    luagram = 'getGroupsInCommon',
    user_id = user_id,
    offset_chat_id = offset_chat_id or 0,
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)
  return function_core.run_table{
    luagram = 'searchMessages',
    query = tostring(query),
    offset_date = offset_date or 0,
    offset_chat_id = offset_chat_id or 0,
    offset_message_id = offset_message_id or 0,
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)
  return function_core.run_table{
    luagram = 'searchChatMessages',
    chat_id = chat_id,
    query = tostring(query),
    sender_user_id = sender_user_id or 0,
    from_message_id = from_message_id or 0,
    offset = offset or 0,
    limit = luagram_function.setLimit(100, limit),
    filter = {
      luagram = 'searchMessagesFilter' .. filter
    }
  }
end
function luagram_function.searchSecretMessages(chat_id, query, from_search_id, limit, filter)
  local filter = filter or 'Empty'
  return function_core.run_table{
    luagram = 'searchSecretMessages',
    chat_id = chat_id or 0,
    query = tostring(query),
    from_search_id = from_search_id or 0,
    limit = luagram_function.setLimit(100, limit),
    filter = {
      luagram = 'searchMessagesFilter' .. filter
    }
  }
end
function luagram_function.deleteChatHistory(chat_id, remove_from_chat_list)
  return function_core.run_table{
    luagram = 'deleteChatHistory',
    chat_id = chat_id,
    remove_from_chat_list = remove_from_chat_list
  }
end
function luagram_function.searchCallMessages(from_message_id, limit, only_missed)
  return function_core.run_table{
    luagram = 'searchCallMessages',
    from_message_id = from_message_id or 0,
    limit = luagram_function.setLimit(100, limit),
    only_missed = only_missed
  }
end
function luagram_function.getChatMessageByDate(chat_id, date)
  return function_core.run_table{
    luagram = 'getChatMessageByDate',
    chat_id = chat_id,
    date = date
  }
end
function luagram_function.getPublicMessageLink(chat_id, message_id, for_album)
  return function_core.run_table{
    luagram = 'getPublicMessageLink',
    chat_id = chat_id,
    message_id = message_id,
    for_album = for_album
  }
end
function luagram_function.sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)
  return function_core.run_table{
    luagram = 'sendMessageAlbum',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id or 0,
    disable_notification = disable_notification,
    from_background = from_background,
    input_message_contents = luagram_function.vectorize(input_message_contents)
  }
end
function luagram_function.sendBotStartMessage(bot_user_id, chat_id, parameter)
  return function_core.run_table{
    luagram = 'sendBotStartMessage',
    bot_user_id = bot_user_id,
    chat_id = chat_id,
    parameter = tostring(parameter)
  }
end
function luagram_function.sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)
  return function_core.run_table{
    luagram = 'sendInlineQueryResultMessage',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id,
    disable_notification = disable_notification,
    from_background = from_background,
    query_id = query_id,
    result_id = tostring(result_id)
  }
end
function luagram_function.forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album)
  return function_core.run_table{
    luagram = 'forwardMessages',
    chat_id = chat_id,
    from_chat_id = from_chat_id,
    message_ids = luagram_function.vectorize(message_ids),
    disable_notification = disable_notification,
    from_background = from_background,
    as_album = as_album
  }
end
function luagram_function.sendChatSetTtlMessage(chat_id, ttl)
  return function_core.run_table{
    luagram = 'sendChatSetTtlMessage',
    chat_id = chat_id,
    ttl = ttl
  }
end
function luagram_function.sendChatScreenshotTakenNotification(chat_id)
  return function_core.run_table{
    luagram = 'sendChatScreenshotTakenNotification',
    chat_id = chat_id
  }
end
function luagram_function.deleteMessages(chat_id, message_ids, revoke)
  return function_core.run_table{
    luagram = 'deleteMessages',
    chat_id = chat_id,
    message_ids = luagram_function.vectorize(message_ids),
    revoke = revoke
  }
end
function luagram_function.deleteChatMessagesFromUser(chat_id, user_id)
  return function_core.run_table{
    luagram = 'deleteChatMessagesFromUser',
    chat_id = chat_id,
    user_id = user_id
  }
end
function luagram_function.editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)
  local luagram_body = {
    luagram = 'editMessageText',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup,
    input_message_content = {
      luagram = 'inputMessageText',
      disable_web_page_preview = disable_web_page_preview,
      text = {
        text = text
      },
      clear_draft = clear_draft
    }
  }
  if parse_mode then
    luagram_body.input_message_content.text = luagram_function.parseTextEntities(text, parse_mode)
  end
  return function_core.run_table(luagram_body)
end
function luagram_function.editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)
  local luagram_body = {
    luagram = 'editMessageCaption',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup,
    caption = caption
  }
  if parse_mode then
      luagram_body.caption = luagram_function.parseTextEntities(text,parse_mode)
  end
  return function_core.run_table(luagram_body)
end
function luagram_function.getTextEntities(text)
  return function_core.run_table{
    luagram = 'getTextEntities',
    text = tostring(text)
  }
end
function luagram_function.getFileMimeType(file_name)
  return function_core.run_table{
    luagram = 'getFileMimeType',
    file_name = tostring(file_name)
  }
end
function luagram_function.getFileExtension(mime_type)
  return function_core.run_table{
    luagram = 'getFileExtension',
    mime_type = tostring(mime_type)
  }
end
function luagram_function.getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)
  return function_core.run_table{
    luagram = 'getInlineQueryResults',
    bot_user_id = bot_user_id,
    chat_id = chat_id,
    user_location = {
      luagram = 'location',
      latitude = latitude,
      longitude = longitude
    },
    query = tostring(query),
    offset = tostring(offset)
  }
end
function luagram_function.answerCallbackQuery(callback_query_id, text, show_alert, url, cache_time)
  return function_core.run_table{
        luagram = 'answerCallbackQuery',
        callback_query_id = callback_query_id,
        show_alert = show_alert,
        cache_time = cache_time,
        text = text,
        url = url,
  }
end
function luagram_function.getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)
  return function_core.run_table{
    luagram = 'getCallbackQueryAnswer',
    chat_id = chat_id,
    message_id = message_id,
    payload = {
      luagram = 'callbackQueryPayload' .. payload,
      data = data,
      game_short_name = game_short_name
    }
  }
end
function luagram_function.deleteChatReplyMarkup(chat_id, message_id)
  return function_core.run_table{
    luagram = 'deleteChatReplyMarkup',
    chat_id = chat_id,
    message_id = message_id
  }
end
function luagram_function.sendChatAction(chat_id, action, progress)
  return function_core.run_table{
    luagram = 'sendChatAction',
    chat_id = chat_id,
    action = {
      luagram = 'chatAction' .. action,
      progress = progress or 100
    }
  }
end
function luagram_function.openChat(chat_id)
  return function_core.run_table{
    luagram = 'openChat',
    chat_id = chat_id
  }
end
function luagram_function.closeChat(chat_id)
  return function_core.run_table{
    luagram = 'closeChat',
    chat_id = chat_id
  }
end
function luagram_function.viewMessages(chat_id, message_ids, force_read)
  return function_core.run_table{
    luagram = 'viewMessages',
    chat_id = chat_id,
    message_ids = luagram_function.vectorize(message_ids),
    force_read = force_read
  }
end
function luagram_function.openMessageContent(chat_id, message_id)
  return function_core.run_table{
    luagram = 'openMessageContent',
    chat_id = chat_id,
    message_id = message_id
  }
end
function luagram_function.readAllChatMentions(chat_id)
  return function_core.run_table{
    luagram = 'readAllChatMentions',
    chat_id = chat_id
  }
end
function luagram_function.createPrivateChat(user_id, force)
  return function_core.run_table{
    luagram = 'createPrivateChat',
    user_id = user_id,
    force = force
  }
end
function luagram_function.createBasicGroupChat(basic_group_id, force)
  return function_core.run_table{
    luagram = 'createBasicGroupChat',
    basic_group_id = luagram_function.getChatId(basic_group_id).id,
    force = force
  }
end
function luagram_function.createSupergroupChat(supergroup_id, force)
  return function_core.run_table{
    luagram = 'createSupergroupChat',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    force = force
  }
end
function luagram_function.createSecretChat(secret_chat_id)
  return function_core.run_table{
    luagram = 'createSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function luagram_function.createNewBasicGroupChat(user_ids, title)
  return function_core.run_table{
    luagram = 'createNewBasicGroupChat',
    user_ids = luagram_function.vectorize(user_ids),
    title = tostring(title)
  }
end
function luagram_function.createNewSupergroupChat(title, is_channel, description)
  return function_core.run_table{
    luagram = 'createNewSupergroupChat',
    title = tostring(title),
    is_channel = is_channel,
    description = tostring(description)
  }
end
function luagram_function.createNewSecretChat(user_id)
  return function_core.run_table{
    luagram = 'createNewSecretChat',
    user_id = tonumber(user_id)
  }
end
function luagram_function.upgradeBasicGroupChatToSupergroupChat(chat_id)
  return function_core.run_table{
    luagram = 'upgradeBasicGroupChatToSupergroupChat',
    chat_id = chat_id
  }
end
function luagram_function.setChatPermissions(chat_id, can_send_messages, can_send_media_messages, can_send_polls, can_send_other_messages, can_add_web_page_previews, can_change_info, can_invite_users, can_pin_messages)
  return function_core.run_table{
    luagram = 'setChatPermissions',
    chat_id = chat_id,
     permissions = {
      can_send_messages = can_send_messages,
      can_send_media_messages = can_send_media_messages,
      can_send_polls = can_send_polls,
      can_send_other_messages = can_send_other_messages,
      can_add_web_page_previews = can_add_web_page_previews,
      can_change_info = can_change_info,
      can_invite_users = can_invite_users,
      can_pin_messages = can_pin_messages,
    }
  }
end
function luagram_function.setChatTitle(chat_id, title)
  return function_core.run_table{
    luagram = 'setChatTitle',
    chat_id = chat_id,
    title = tostring(title)
  }
end
function luagram_function.setChatPhoto(chat_id, photo)
  return function_core.run_table{
    luagram = 'setChatPhoto',
    chat_id = chat_id,
    photo = getInputFile(photo)
  }
end
function luagram_function.setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)
  local luagram_body = {
    luagram = 'setChatDraftMessage',
    chat_id = chat_id,
    draft_message = {
      luagram = 'draftMessage',
      reply_to_message_id = reply_to_message_id,
      input_message_text = {
        luagram = 'inputMessageText',
        disable_web_page_preview = disable_web_page_preview,
        text = {text = text},
        clear_draft = clear_draft
      }
    }
  }
  if parse_mode then
      luagram_body.draft_message.input_message_text.text = luagram_function.parseTextEntities(text, parse_mode)
  end
  return function_core.run_table(luagram_body)
end
function luagram_function.toggleChatIsPinned(chat_id, is_pinned)
  return function_core.run_table{
    luagram = 'toggleChatIsPinned',
    chat_id = chat_id,
    is_pinned = is_pinned
  }
end
function luagram_function.setChatClientData(chat_id, client_data)
  return function_core.run_table{
    luagram = 'setChatClientData',
    chat_id = chat_id,
    client_data = tostring(client_data)
  }
end
function luagram_function.addChatMember(chat_id, user_id, forward_limit)
  return function_core.run_table{
    luagram = 'addChatMember',
    chat_id = chat_id,
    user_id = user_id,
    forward_limit = luagram_function.setLimit(300, forward_limit)
  }
end
function luagram_function.addChatMembers(chat_id, user_ids)
  return function_core.run_table{
    luagram = 'addChatMembers',
    chat_id = chat_id,
    user_ids = luagram_function.vectorize(user_ids)
  }
end
function luagram_function.setChatMemberStatus(chat_id, user_id, status, right)
  local right = right and luagram_function.vectorize(right) or {}
  local status = string.lower(status)
  if status == 'creator' then
    chat_member_status = {
      luagram = 'chatMemberStatusCreator',
      is_member = right[1] or 1
    }
  elseif status == 'administrator' then
    chat_member_status = {
      luagram = 'chatMemberStatusAdministrator',
      can_be_edited = right[1] or 1,
      can_change_info = right[2] or 1,
      can_post_messages = right[3] or 1,
      can_edit_messages = right[4] or 1,
      can_delete_messages = right[5] or 1,
      can_invite_users = right[6] or 1,
      can_restrict_members = right[7] or 1,
      can_pin_messages = right[8] or 1,
      can_promote_members = right[9] or 0
    }
  elseif status == 'restricted' then
    chat_member_status = {
      permissions = {
        luagram = 'chatPermissions',
        can_send_polls = right[2] or 0,
        can_add_web_page_previews = right[3] or 1,
        can_change_info = right[4] or 0,
        can_invite_users = right[5] or 1,
        can_pin_messages = right[6] or 0,
        can_send_media_messages = right[7] or 1,
        can_send_messages = right[8] or 1,
        can_send_other_messages = right[9] or 1
      },
      is_member = right[1] or 1,
      restricted_until_date = right[10] or 0,
      luagram = 'chatMemberStatusRestricted'
    }
  elseif status == 'banned' then
    chat_member_status = {
      luagram = 'chatMemberStatusBanned',
      banned_until_date = right[1] or 0
    }
  end
  return function_core.run_table{
    luagram = 'setChatMemberStatus',
    chat_id = chat_id,
    user_id = user_id,
    status = chat_member_status or {}
  }
end


function luagram_function.getChatMember(chat_id, user_id)
  return function_core.run_table{
    luagram = 'getChatMember',
    chat_id = chat_id,
    user_id = user_id
  }
end
function luagram_function.searchChatMembers(chat_id, query, limit)
  return function_core.run_table{
    luagram = 'searchChatMembers',
    chat_id = chat_id,
    query = tostring(query),
    limit = luagram_function.setLimit(200, limit)
  }
end
function luagram_function.getChatAdministrators(chat_id)
  return function_core.run_table{
    luagram = 'getChatAdministrators',
    chat_id = chat_id
  }
end
function luagram_function.setPinnedChats(chat_ids)
  return function_core.run_table{
    luagram = 'setPinnedChats',
    chat_ids = luagram_function.vectorize(chat_ids)
  }
end
function luagram_function.downloadFile(file_id, priority)
  return function_core.run_table{
    luagram = 'downloadFile',
    file_id = file_id,
    priority = priority or 32
  }
end
function luagram_function.cancelDownloadFile(file_id, only_if_pending)
  return function_core.run_table{
    luagram = 'cancelDownloadFile',
    file_id = file_id,
    only_if_pending = only_if_pending
  }
end
function luagram_function.uploadFile(file, file_type, priority)
  local ftype = file_type or 'Unknown'
  return function_core.run_table{
    luagram = 'uploadFile',
    file = luagram_function.getInputFile(file),
    file_type = {
      luagram = 'fileType' .. ftype
    },
    priority = priority or 32
  }
end
function luagram_function.cancelUploadFile(file_id)
  return function_core.run_table{
    luagram = 'cancelUploadFile',
    file_id = file_id
  }
end
function luagram_function.deleteFile(file_id)
  return function_core.run_table{
    luagram = 'deleteFile',
    file_id = file_id
  }
end
function luagram_function.generateChatInviteLink(chat_id)
  return function_core.run_table{
    luagram = 'generateChatInviteLink',
    chat_id = chat_id
  }
end
function luagram_function.joinChatByUsernam(username)
  if type(username) == 'string' and 5 <= #username then
    local result = luagram_function.searchPublicChat(username)
    if result.type and result.type.luagram == 'chatTypeSupergroup' then
      return function_core.run_table{
        luagram = 'joinChat',
        chat_id = result.id
      }
    else
      return result
    end
  end
end
function luagram_function.checkChatInviteLink(invite_link)
  return function_core.run_table{
    luagram = 'checkChatInviteLink',
    invite_link = tostring(invite_link)
  }
end
function luagram_function.joinChatByInviteLink(invite_link)
  return function_core.run_table{
    luagram = 'joinChatByInviteLink',
    invite_link = tostring(invite_link)
  }
end
function luagram_function.leaveChat(chat_id)
  return  function_core.run_table{
    luagram = 'leaveChat',
    chat_id = chat_id
  }
end
function luagram_function.createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)
  return function_core.run_table{
    luagram = 'createCall',
    user_id = user_id,
    protocol = {
      luagram = 'callProtocol',
      udp_p2p = udp_p2p,
      udp_reflector = udp_reflector,
      min_layer = min_layer or 65,
      max_layer = max_layer or 65
    }
  }
end
function luagram_function.acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)
  return function_core.run_table{
    luagram = 'acceptCall',
    call_id = call_id,
    protocol = {
      luagram = 'callProtocol',
      udp_p2p = udp_p2p,
      udp_reflector = udp_reflector,
      min_layer = min_layer or 65,
      max_layer = max_layer or 65
    }
  }
end
function luagram_function.blockUser(user_id)
  return function_core.run_table{
    luagram = 'blockUser',
    user_id = user_id
  }
end
function luagram_function.unblockUser(user_id)
  return function_core.run_table{
    luagram = 'unblockUser',
    user_id = user_id
  }
end
function luagram_function.getBlockedUsers(offset, limit)
  return function_core.run_table{
    luagram = 'getBlockedUsers',
    offset = offset or 0,
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.importContacts(phone_number, first_name, last_name, user_id)
  return function_core.run_table{
    luagram = 'importContacts',
    contacts = {
      luagram = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id or 0
    }
  }
end
function luagram_function.searchContacts(query, limit)
  return function_core.run_table{
    luagram = 'searchContacts',
    query = tostring(query),
    limit = limit
  }
end
function luagram_function.removeContacts(user_ids)
  return function_core.run_table{
    luagram = 'removeContacts',
    user_ids = luagram_function.vectorize(user_ids)
  }
end
function luagram_function.getImportedContactCount()
  return function_core.run_table{
    luagram = 'getImportedContactCount'
  }
end
function luagram_function.changeImportedContacts(phone_number, first_name, last_name, user_id)
  return function_core.run_table{
    luagram = 'changeImportedContacts',
    contacts = {
      luagram = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id or 0
    }
  }
end
function luagram_function.clearImportedContacts()
  return function_core.run_table{
    luagram = 'clearImportedContacts'
  }
end
function luagram_function.getUserProfilePhotos(user_id, offset, limit)
  return function_core.run_table{
    luagram = 'getUserProfilePhotos',
    user_id = user_id,
    offset = offset or 0,
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.getStickers(emoji, limit)
  return function_core.run_table{
    luagram = 'getStickers',
    emoji = tostring(emoji),
    limit = luagram_function.setLimit(100, limit)
  }
end
function luagram_function.searchStickers(emoji, limit)
  return function_core.run_table{
    luagram = 'searchStickers',
    emoji = tostring(emoji),
    limit = limit
  }
end
function luagram_function.getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)
  return function_core.run_table{
    luagram = 'getArchivedStickerSets',
    is_masks = is_masks,
    offset_sticker_set_id = offset_sticker_set_id,
    limit = limit
  }
end
function luagram_function.getTrendingStickerSets()
  return function_core.run_table{
    luagram = 'getTrendingStickerSets'
  }
end
function luagram_function.getAttachedStickerSets(file_id)
  return function_core.run_table{
    luagram = 'getAttachedStickerSets',
    file_id = file_id
  }
end
function luagram_function.getStickerSet(set_id)
  return function_core.run_table{
    luagram = 'getStickerSet',
    set_id = set_id
  }
end
function luagram_function.searchStickerSet(name)
  return function_core.run_table{
    luagram = 'searchStickerSet',
    name = tostring(name)
  }
end
function luagram_function.searchInstalledStickerSets(is_masks, query, limit)
  return function_core.run_table{
    luagram = 'searchInstalledStickerSets',
    is_masks = is_masks,
    query = tostring(query),
    limit = limit
  }
end
function luagram_function.searchStickerSets(query)
  return function_core.run_table{
    luagram = 'searchStickerSets',
    query = tostring(query)
  }
end
function luagram_function.changeStickerSet(set_id, is_installed, is_archived)
  return function_core.run_table{
    luagram = 'changeStickerSet',
    set_id = set_id,
    is_installed = is_installed,
    is_archived = is_archived
  }
end
function luagram_function.viewTrendingStickerSets(sticker_set_ids)
  return function_core.run_table{
    luagram = 'viewTrendingStickerSets',
    sticker_set_ids = luagram_function.vectorize(sticker_set_ids)
  }
end
function luagram_function.reorderInstalledStickerSets(is_masks, sticker_set_ids)
  return function_core.run_table{
    luagram = 'reorderInstalledStickerSets',
    is_masks = is_masks,
    sticker_set_ids = luagram_function.vectorize(sticker_set_ids)
  }
end
function luagram_function.getRecentStickers(is_attached)
  return function_core.run_table{
    luagram = 'getRecentStickers',
    is_attached = is_attached
  }
end
function luagram_function.addRecentSticker(is_attached, sticker)
  return function_core.run_table{
    luagram = 'addRecentSticker',
    is_attached = is_attached,
    sticker = luagram_function.getInputFile(sticker)
  }
end
function luagram_function.clearRecentStickers(is_attached)
  return function_core.run_table{
    luagram = 'clearRecentStickers',
    is_attached = is_attached
  }
end
function luagram_function.getFavoriteStickers()
  return function_core.run_table{
    luagram = 'getFavoriteStickers'
  }
end
function luagram_function.addFavoriteSticker(sticker)
  return function_core.run_table{
    luagram = 'addFavoriteSticker',
    sticker = luagram_function.getInputFile(sticker)
  }
end
function luagram_function.removeFavoriteSticker(sticker)
  return function_core.run_table{
    luagram = 'removeFavoriteSticker',
    sticker = luagram_function.getInputFile(sticker)
  }
end
function luagram_function.getStickerEmojis(sticker)
  return function_core.run_table{
    luagram = 'getStickerEmojis',
    sticker = luagram_function.getInputFile(sticker)
  }
end
function luagram_function.getSavedAnimations()
  return function_core.run_table{
    luagram = 'getSavedAnimations'
  }
end
function luagram_function.addSavedAnimation(animation)
  return function_core.run_table{
    luagram = 'addSavedAnimation',
    animation = luagram_function.getInputFile(animation)
  }
end
function luagram_function.removeSavedAnimation(animation)
  return function_core.run_table{
    luagram = 'removeSavedAnimation',
    animation = luagram_function.getInputFile(animation)
  }
end
function luagram_function.getRecentInlineBots()
  return function_core.run_table{
    luagram = 'getRecentInlineBots'
  }
end
function luagram_function.searchHashtags(prefix, limit)
  return function_core.run_table{
    luagram = 'searchHashtags',
    prefix = tostring(prefix),
    limit = limit
  }
end
function luagram_function.removeRecentHashtag(hashtag)
  return function_core.run_table{
    luagram = 'removeRecentHashtag',
    hashtag = tostring(hashtag)
  }
end
function luagram_function.getWebPagePreview(text)
  return function_core.run_table{
    luagram = 'getWebPagePreview',
    text = {
      text = text
    }
  }
end
function luagram_function.getWebPageInstantView(url, force_full)
  return function_core.run_table{
    luagram = 'getWebPageInstantView',
    url = tostring(url),
    force_full = force_full
  }
end
function luagram_function.getNotificationSettings(scope, chat_id)
  return function_core.run_table{
    luagram = 'getNotificationSettings',
    scope = {
      luagram = 'notificationSettingsScope' .. scope,
      chat_id = chat_id
    }
  }
end
function luagram_function.setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)
  return function_core.run_table{
    luagram = 'setNotificationSettings',
    scope = {
      luagram = 'notificationSettingsScope' .. scope,
      chat_id = chat_id
    },
    notification_settings = {
      luagram = 'notificationSettings',
      mute_for = mute_for,
      sound = tostring(sound),
      show_preview = show_preview
    }
  }
end
function luagram_function.resetAllNotificationSettings()
  return function_core.run_table{
    luagram = 'resetAllNotificationSettings'
  }
end
function luagram_function.setProfilePhoto(photo)
  return function_core.run_table{
    luagram = 'setProfilePhoto',
    photo = luagram_function.getInputFile(photo)
  }
end
function luagram_function.deleteProfilePhoto(profile_photo_id)
  return function_core.run_table{
    luagram = 'deleteProfilePhoto',
    profile_photo_id = profile_photo_id
  }
end
function luagram_function.setName(first_name, last_name)
  return function_core.run_table{
    luagram = 'setName',
    first_name = tostring(first_name),
    last_name = tostring(last_name)
  }
end
function luagram_function.setBio(bio)
  return function_core.run_table{
    luagram = 'setBio',
    bio = tostring(bio)
  }
end
function luagram_function.setUsername(username)
  return function_core.run_table{
    luagram = 'setUsername',
    username = tostring(username)
  }
end
function luagram_function.getActiveSessions()
  return function_core.run_table{
    luagram = 'getActiveSessions'
  }
end
function luagram_function.terminateAllOtherSessions()
  return function_core.run_table{
    luagram = 'terminateAllOtherSessions'
  }
end
function luagram_function.terminateSession(session_id)
  return function_core.run_table{
    luagram = 'terminateSession',
    session_id = session_id
  }
end
function luagram_function.toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)
  return function_core.run_table{
    luagram = 'toggleBasicGroupAdministrators',
    basic_group_id = luagram_function.getChatId(basic_group_id).id,
    everyone_is_administrator = everyone_is_administrator
  }
end
function luagram_function.setSupergroupUsername(supergroup_id, username)
  return function_core.run_table{
    luagram = 'setSupergroupUsername',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    username = tostring(username)
  }
end
function luagram_function.setSupergroupStickerSet(supergroup_id, sticker_set_id)
  return function_core.run_table{
    luagram = 'setSupergroupStickerSet',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    sticker_set_id = sticker_set_id
  }
end
function luagram_function.toggleSupergroupInvites(supergroup_id, anyone_can_invite)
  return function_core.run_table{
    luagram = 'toggleSupergroupInvites',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    anyone_can_invite = anyone_can_invite
  }
end
function luagram_function.toggleSupergroupSignMessages(supergroup_id, sign_messages)
  return function_core.run_table{
    luagram = 'toggleSupergroupSignMessages',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    sign_messages = sign_messages
  }
end
function luagram_function.toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)
  return function_core.run_table{
    luagram = 'toggleSupergroupIsAllHistoryAvailable',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    is_all_history_available = is_all_history_available
  }
end
function luagram_function.setChatDescription(chat_id, description)
  return function_core.run_table{
    luagram = 'setChatDescription',
    chat_id = chat_id,
    description = tostring(description)
  }
end
function luagram_function.pinChatMessage(chat_id, message_id, disable_notification)
  return function_core.run_table{
    luagram = 'pinChatMessage',
    chat_id = chat_id,
    message_id = message_id,
    disable_notification = disable_notification
  }
end
function luagram_function.unpinChatMessage(chat_id)
  return function_core.run_table{
    luagram = 'unpinChatMessage',
    chat_id = chat_id
  }
end
function luagram_function.reportSupergroupSpam(supergroup_id, user_id, message_ids)
  return function_core.run_table{
    luagram = 'reportSupergroupSpam',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    user_id = user_id,
    message_ids = luagram_function.vectorize(message_ids)
  }
end
function luagram_function.getSupergroupMembers(supergroup_id, filter, query, offset, limit)
  local filter = filter or 'Recent'
  return function_core.run_table{
    luagram = 'getSupergroupMembers',
    supergroup_id = luagram_function.getChatId(supergroup_id).id,
    filter = {
      luagram = 'supergroupMembersFilter' .. filter,
      query = query
    },
    offset = offset or 0,
    limit = luagram_function.setLimit(200, limit)
  }
end
function luagram_function.deleteSupergroup(supergroup_id)
  return function_core.run_table{
    luagram = 'deleteSupergroup',
    supergroup_id = luagram_function.getChatId(supergroup_id).id
  }
end
function luagram_function.closeSecretChat(secret_chat_id)
  return function_core.run_table{
    luagram = 'closeSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function luagram_function.getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)
  local filters = filters or {1,1,1,1,1,1,1,1,1,1}
  return function_core.run_table{
    luagram = 'getChatEventLog',
    chat_id = chat_id,
    query = tostring(query) or '',
    from_event_id = from_event_id or 0,
    limit = luagram_function.setLimit(100, limit),
    filters = {
      luagram = 'chatEventLogFilters',
      message_edits = filters[0],
      message_deletions = filters[1],
      message_pins = filters[2],
      member_joins = filters[3],
      member_leaves = filters[4],
      member_invites = filters[5],
      member_promotions = filters[6],
      member_restrictions = filters[7],
      info_changes = filters[8],
      setting_changes = filters[9]
    },
    user_ids = luagram_function.vectorize(user_ids)
  }
end
function luagram_function.getSavedOrderInfo()
  return function_core.run_table{
    luagram = 'getSavedOrderInfo'
  }
end
function luagram_function.deleteSavedOrderInfo()
  return function_core.run_table{
    luagram = 'deleteSavedOrderInfo'
  }
end
function luagram_function.deleteSavedCredentials()
  return function_core.run_table{
    luagram = 'deleteSavedCredentials'
  }
end
function luagram_function.getSupportUser()
  return function_core.run_table{
    luagram = 'getSupportUser'
  }
end
function luagram_function.getWallpapers()
  return function_core.run_table{
    luagram = 'getWallpapers'
  }
end
function luagram_function.setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)
  local setting_rules = {
    [0] = {
      luagram = 'userPrivacySettingRule' .. rules
    }
  }
  if allowed_user_ids then
    setting_rules[#setting_rules + 1] = {
      {
        luagram = 'userPrivacySettingRuleAllowUsers',
        user_ids = luagram_function.vectorize(allowed_user_ids)
      }
    }
  elseif restricted_user_ids then
    setting_rules[#setting_rules + 1] = {
      {
        luagram = 'userPrivacySettingRuleRestrictUsers',
        user_ids = luagram_function.vectorize(restricted_user_ids)
      }
    }
  end
  return function_core.run_table{
    luagram = 'setUserPrivacySettingRules',
    setting = {
      luagram = 'userPrivacySetting' .. setting
    },
    rules = {
      luagram = 'userPrivacySettingRules',
      rules = setting_rules
    }
  }
end
function luagram_function.getUserPrivacySettingRules(setting)
  return function_core.run_table{
    luagram = 'getUserPrivacySettingRules',
    setting = {
      luagram = 'userPrivacySetting' .. setting
    }
  }
end
function luagram_function.getOption(name)
  return function_core.run_table{
    luagram = 'getOption',
    name = tostring(name)
  }
end
function luagram_function.setOption(name, option_value, value)
  return function_core.run_table{
    luagram = 'setOption',
    name = tostring(name),
    value = {
      luagram = 'optionValue' .. option_value,
      value = value
    }
  }
end
function luagram_function.setAccountTtl(ttl)
  return function_core.run_table{
    luagram = 'setAccountTtl',
    ttl = {
      luagram = 'accountTtl',
      days = ttl
    }
  }
end
function luagram_function.getAccountTtl()
  return function_core.run_table{
    luagram = 'getAccountTtl'
  }
end
function luagram_function.deleteAccount(reason)
  return function_core.run_table{
    luagram = 'deleteAccount',
    reason = tostring(reason)
  }
end
function luagram_function.getChatReportSpamState(chat_id)
  return function_core.run_table{
    luagram = 'getChatReportSpamState',
    chat_id = chat_id
  }
end
function luagram_function.reportChat(chat_id, reason, text, message_ids)
  return function_core.run_table{
    luagram = 'reportChat',
    chat_id = chat_id,
    reason = {
      luagram = 'chatReportReason' .. reason,
      text = text
    },
    message_ids = luagram_function.vectorize(message_ids)
  }
end
function luagram_function.getStorageStatistics(chat_limit)
  return function_core.run_table{
    luagram = 'getStorageStatistics',
    chat_limit = chat_limit
  }
end
function luagram_function.getStorageStatisticsFast()
  return function_core.run_table{
    luagram = 'getStorageStatisticsFast'
  }
end
function luagram_function.optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)
  local file_type = file_type or ''
  return function_core.run_table{
    luagram = 'optimizeStorage',
    size = size or -1,
    ttl = ttl or -1,
    count = count or -1,
    immunity_delay = immunity_delay or -1,
    file_type = {
      luagram = 'fileType' .. file_type
    },
    chat_ids = luagram_function.vectorize(chat_ids),
    exclude_chat_ids = luagram_function.vectorize(exclude_chat_ids),
    chat_limit = chat_limit
  }
end
function luagram_function.setNetworkType(type)
  return function_core.run_table{
    luagram = 'setNetworkType',
    type = {
      luagram = 'networkType' .. type
    },
  }
end
function luagram_function.getNetworkStatistics(only_current)
  return function_core.run_table{
    luagram = 'getNetworkStatistics',
    only_current = only_current
  }
end
function luagram_function.addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)
  local file_type = file_type or 'None'
  return function_core.run_table{
    luagram = 'addNetworkStatistics',
    entry = {
      luagram = 'networkStatisticsEntry' .. entry,
      file_type = {
        luagram = 'fileType' .. file_type
      },
      network_type = {
        luagram = 'networkType' .. network_type
      },
      sent_bytes = sent_bytes,
      received_bytes = received_bytes,
      duration = duration
    }
  }
end
function luagram_function.resetNetworkStatistics()
  return function_core.run_table{
    luagram = 'resetNetworkStatistics'
  }
end
function luagram_function.getCountryCode()
  return function_core.run_table{
    luagram = 'getCountryCode'
  }
end
function luagram_function.getInviteText()
  return function_core.run_table{
    luagram = 'getInviteText'
  }
end
function luagram_function.getTermsOfService()
  return function_core.run_table{
    luagram = 'getTermsOfService'
  }
end
function luagram_function.sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageText',
    disable_web_page_preview = disable_web_page_preview,
    text = {text = text},
    clear_draft = clear_draft
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageAnimation',
    animation = luagram_function.getInputFile(animation),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    duration = duration,
    width = width,
    height = height
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageAudio',
    audio = luagram_function.getInputFile(audio),
    album_cover_thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    duration = duration,
    title = tostring(title),
    performer = tostring(performer)
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageDocument',
    document = luagram_function.getInputFile(document),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption}
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessagePhoto',
    photo = luagram_function.getInputFile(photo),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    added_sticker_file_ids = luagram_function.vectorize(added_sticker_file_ids),
    width = width,
    height = height,
    ttl = ttl or 0
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageSticker',
    sticker = luagram_function.getInputFile(sticker),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    width = width,
    height = height
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageVideo',
    video = luagram_function.getInputFile(video),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    added_sticker_file_ids = luagram_function.vectorize(added_sticker_file_ids),
    duration = duration,
    width = width,
    height = height,
    ttl = ttl
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageVideoNote',
    video_note = luagram_function.getInputFile(video_note),
    thumbnail = {
      luagram = 'inputThumbnail',
      thumbnail = luagram_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    duration = duration,
    length = length
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageVoiceNote',
    voice_note = luagram_function.getInputFile(voice_note),
    caption = {text = caption},
    duration = duration,
    waveform = waveform
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageLocation',
    location = {
      luagram = 'location',
      latitude = latitude,
      longitude = longitude
    },
    live_period = liveperiod
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageVenue',
    venue = {
      luagram = 'venue',
      location = {
        luagram = 'location',
        latitude = latitude,
        longitude = longitude
      },
      title = tostring(title),
      address = tostring(address),
      provider = tostring(provider),
      id = tostring(id)
    }
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageContact',
    contact = {
      luagram = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id
    }
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageInvoice',
    invoice = invoice,
    title = tostring(title),
    description = tostring(description),
    photo_url = tostring(photo_url),
    photo_size = photo_size,
    photo_width = photo_width,
    photo_height = photo_height,
    payload = payload,
    provider_token = tostring(provider_token),
    provider_data = tostring(provider_data),
    start_parameter = tostring(start_parameter)
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)
  local input_message_content = {
    luagram = 'inputMessageForwarded',
    from_chat_id = from_chat_id,
    message_id = message_id,
    in_game_share = in_game_share
  }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luagram_function.sendPoll(chat_id, reply_to_message_id, question, options, pollType, is_anonymous, allow_multiple_answers)
  local input_message_content = {
      luagram = 'inputMessagePoll',
      is_anonymous = is_anonymous,
      question = question,
      type = {
        luagram = 'pollType'..pollType,
        allow_multiple_answers = allow_multiple_answers
      },
      options = options
    }
  return luagram_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luagram_function.getPollVoters(chat_id, message_id, option_id, offset, limit)
  return function_core.run_table{
    luagram = 'getPollVoters',
    chat_id = chat_id,
    message_id = message_id,
    option_id = option_id,
    limit = luagram_function.setLimit(50 , limit),
    offset = offset
  }
end
function luagram_function.setPollAnswer(chat_id, message_id, option_ids)
  return function_core.run_table{
    luagram = 'setPollAnswer',
    chat_id = chat_id,
    message_id = message_id,
    option_ids = option_ids
  }
end
function luagram_function.stopPoll(chat_id, message_id, reply_markup)
  return function_core.run_table{
    luagram = 'stopPoll',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup
  }
end
function luagram_function.getInputMessage(value)
  if type(value) ~= 'table' then
    return value
  end
  if type(value.type) == 'string' then
    if value.parse_mode and value.caption then
      caption = luagram_function.parseTextEntities(value.caption, value.parse_mode)
    elseif value.caption and not value.parse_mode then
      caption = {
        text = value.caption
      }
    elseif value.parse_mode and value.text then
      text = luagram_function.parseTextEntities(value.text, value.parse_mode)
    elseif not value.parse_mode and value.text then
      text = {
        text = value.text
      }
    end
    value.type = string.lower(value.type)
    if value.type == 'text' then
      return {
        luagram = 'inputMessageText',
        disable_web_page_preview = value.disable_web_page_preview,
        text = text,
        clear_draft = value.clear_draft
      }
    elseif value.type == 'animation' then
      return {
        luagram = 'inputMessageAnimation',
        animation = luagram_function.getInputFile(value.animation),
        thumbnail = {
          luagram = 'inputThumbnail',
          thumbnail = luagram_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        duration = value.duration,
        width = value.width,
        height = value.height
      }
    elseif value.type == 'audio' then
      return {
        luagram = 'inputMessageAudio',
        audio = luagram_function.getInputFile(value.audio),
        album_cover_thumbnail = {
          luagram = 'inputThumbnail',
          thumbnail = luagram_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        duration = value.duration,
        title = tostring(value.title),
        performer = tostring(value.performer)
      }
    elseif value.type == 'document' then
      return {
        luagram = 'inputMessageDocument',
        document = luagram_function.getInputFile(value.document),
        thumbnail = {
          luagram = 'inputThumbnail',
          thumbnail = luagram_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption
      }
    elseif value.type == 'photo' then
      return {
        luagram = 'inputMessagePhoto',
        photo = luagram_function.getInputFile(value.photo),
        thumbnail = {
          luagram = 'inputThumbnail',
          thumbnail = luagram_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        added_sticker_file_ids = luagram_function.vectorize(value.added_sticker_file_ids),
        width = value.width,
        height = value.height,
        ttl = value.ttl or 0
      }
    elseif value.text == 'video' then
      return {
        luagram = 'inputMessageVideo',
        video = luagram_function.getInputFile(value.video),
        thumbnail = {
          luagram = 'inputThumbnail',
          thumbnail = luagram_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        added_sticker_file_ids = luagram_function.vectorize(value.added_sticker_file_ids),
        duration = value.duration,
        width = value.width,
        height = value.height,
        ttl = value.ttl or 0
      }
    elseif value.text == 'videonote' then
      return {
        luagram = 'inputMessageVideoNote',
        video_note = luagram_function.getInputFile(value.video_note),
        thumbnail = {
          luagram = 'inputThumbnail',
          thumbnail = luagram_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        duration = value.duration,
        length = value.length
      }
    elseif value.text == 'voice' then
      return {
        luagram = 'inputMessageVoiceNote',
        voice_note = luagram_function.getInputFile(value.voice_note),
        caption = caption,
        duration = value.duration,
        waveform = value.waveform
      }
    elseif value.text == 'location' then
      return {
        luagram = 'inputMessageLocation',
        location = {
          luagram = 'location',
          latitude = value.latitude,
          longitude = value.longitude
        },
        live_period = value.liveperiod
      }
    elseif value.text == 'contact' then
      return {
        luagram = 'inputMessageContact',
        contact = {
          luagram = 'contact',
          phone_number = tostring(value.phone_number),
          first_name = tostring(value.first_name),
          last_name = tostring(value.last_name),
          user_id = value.user_id
        }
      }
    elseif value.text == 'contact' then
      return {
        luagram = 'inputMessageContact',
        contact = {
          luagram = 'contact',
          phone_number = tostring(value.phone_number),
          first_name = tostring(value.first_name),
          last_name = tostring(value.last_name),
          user_id = value.user_id
        }
      }
    end
  end
end
function luagram_function.answerInlineQuery(inline_query_id, results, next_offset, switch_pm_text, switch_pm_parameter, is_personal, cache_time)
  local answerInlineQueryResults = {}
  for key, value in pairs(results) do
    local newAnswerInlineQueryResults_id = #answerInlineQueryResults + 1
    if type(value) == 'table' and type(value.type) == 'string' then
      value.type = string.lower(value.type)
      if value.type == 'gif' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultAnimatedGif',
          id = value.id,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          gif_url = value.gif_url,
          gif_duration = value.gif_duration,
          gif_width = value.gif_width,
          gif_height = value.gif_height,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'mpeg4' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultAnimatedMpeg4',
          id = value.id,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          mpeg4_url = value.mpeg4_url,
          mpeg4_duration = value.mpeg4_duration,
          mpeg4_width = value.mpeg4_width,
          mpeg4_height = value.mpeg4_height,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'article' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultArticle',
          id = value.id,
          url = value.url,
          hide_url = value.hide_url,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'audio' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultAudio',
          id = value.id,
          title = value.title,
          performer = value.performer,
          audio_url = value.audio_url,
          audio_duration = value.audio_duration,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'contact' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultContact',
          id = value.id,
          contact = value.contact,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = thumbnail_height.description,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'document' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultDocument',
          id = value.id,
          title = value.title,
          description = value.description,
          document_url = value.document_url,
          mime_type = value.mime_type,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'game' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultGame',
          id = value.id,
          game_short_name = value.game_short_name,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'location' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultLocation',
          id = value.id,
          location = value.location,
          live_period = value.live_period,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'photo' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultPhoto',
          id = value.id,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          photo_url = value.photo_url,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'sticker' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultSticker',
          id = value.id,
          thumbnail_url = value.thumbnail_url,
          sticker_url = value.sticker_url,
          sticker_width = value.sticker_width,
          sticker_height = value.sticker_height,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'sticker' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultSticker',
          id = value.id,
          thumbnail_url = value.thumbnail_url,
          sticker_url = value.sticker_url,
          sticker_width = value.sticker_width,
          sticker_height = value.sticker_height,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'video' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultVideo',
          id = value.id,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          video_url = value.video_url,
          mime_type = value.mime_type,
          video_width = value.video_width,
          video_height = value.video_height,
          video_duration = value.video_duration,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      elseif value.type == 'videonote' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          luagram = 'inputInlineQueryResultVoiceNote',
          id = value.id,
          title = value.title,
          voice_note_url = value.voice_note_url,
          voice_note_duration = value.voice_note_duration,
          reply_markup = luagram_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = luagram_function.getInputMessage(value.input)
        }
      end
    end
  end
  return function_core.run_table{
    luagram = 'answerInlineQuery',
    inline_query_id = inline_query_id,
    next_offset = next_offset,
    switch_pm_text = switch_pm_text,
    switch_pm_parameter = switch_pm_parameter,
    is_personal = is_personal,
    cache_time = cache_time,
    results = answerInlineQueryResults,
  }
end
function luagram.VERSION()
  print(luagram_function.colors('%{yellow}\27[5m'..luagram.logo))
  return true
end
function luagram.run(main_def, filters)
  if type(main_def) ~= 'function' then
    function_core.print_error('the run main_def must be a main function !')
    os.exit(1)
  else
    update_functions[0] = {}
    update_functions[0].def = main_def
    update_functions[0].filters = filters
  end
  while luagram.get_update do
    for timer_id, timer_data in pairs(luagram_timer) do
      if os.time() >= timer_data.run_in then
        xpcall(timer_data.def, function_core.print_error,timer_data.argv)
        table.remove(luagram_timer,timer_id)
      end
    end
    local update = function_core.change_table(client:get(1))
    if update then
      if type(update) ~= 'table' then
          goto finish
      end
      if luagram.login(update) then
        function_core._CALL_(update)
      end
    end
    ::finish::
  end
end
function luagram.set_config(data)
  luagram.VERSION()
  if not data.api_hash then
    print(luagram_function.colors('%{red} please use api_hash in your script !'))
    os.exit()
  end
  if not data.api_id then
    print(luagram_function.colors('%{red} please use api_id in your script !'))
    os.exit()
  end
  if not data.session_name then
    print(luagram_function.colors('%{red} please use session_name in your script !'))
    os.exit()
  end
  if not data.token and not luagram_function.exists('.luagram-sessions/'..data.session_name) then
    io.write(luagram_function.colors('\n%{green} please use your token or phone number > '))
    local phone_token = io.read()
    if phone_token:match('%d+:') then
      luagram.config.is_bot = true
      luagram.config.token = phone_token
    else
      luagram.config.is_bot = false
      luagram.config.phone = phone_token
    end
  elseif data.token and not luagram_function.exists('.luagram-sessions/'..data.session_name) then
    luagram.config.is_bot = true
    luagram.config.token = data.token
  end
  if not luagram_function.exists('.luagram-sessions') then
    os.execute('sudo makdir .luagram-sessions')
  end
  luagram.config.encryption_key = data.encryption_key or ''
  luagram.config.parameters = {
    luagram = 'setTdlibParameters',
    use_message_database = data.use_message_database or true,
    api_id = data.api_id,
    api_hash = data.api_hash,
    use_secret_chats = use_secret_chats or true,
    system_language_code = data.language_code or 'en',
    device_model = data.device_model or 'luagram',
    system_version = data.system_version or 'linux',
    application_version = data.app_version or '1.0',
    enable_storage_optimizer = data.enable_storage_optimizer or true,
    use_pfs = data.use_pfs or true,
    database_directory = '.luagram-sessions/'..data.session_name
  }
  return luagram_function
end
function luagram.login(state)
  if state.name == 'version' and state.value and state.value.value then
    print(luagram_function.colors('%{magenta}TDLIB VERSION : '..state.value.value),'\n\n')
  elseif state.authorization_state and state.authorization_state.luagram == 'error' and (state.authorization_state.message == 'PHONE_NUMBER_INVALID' or state.authorization_state.message == 'ACCESS_TOKEN_INVALID') then
    if state.authorization_state.message == 'PHONE_NUMBER_INVALID' then
      print(luagram_function.colors('%{red} phone number invalid !'))
    else
      print(luagram_function.colors('%{red} access token invalid !'))
    end
    io.write(luagram_function.colors('\n%{green} please use your token or phone number > '))
    local phone_token = io.read()
    if phone_token:match('%d+:') then
      function_core.send_tdlib{
        luagram = 'checkAuthenticationBotToken',
        token = phone_token
      }
    else
      function_core.send_tdlib{
        luagram = 'setAuthenticationPhoneNumber',
        phone_number = phone_token
      }
    end
  elseif state.authorization_state and state.authorization_state.luagram == 'error' and state.authorization_state.message == 'PHONE_CODE_INVALID' then
    io.write(luagram_function.colors('\n%{green} code > '))
    local code = io.read()
    function_core.send_tdlib{
      luagram = 'checkAuthenticationCode',
      code = code
    }
  elseif state.authorization_state and state.authorization_state.luagram == 'error' and state.authorization_state.message == 'PASSWORD_HASH_INVALID' then
    print(luagram_function.colors('%{red}two-step is wrong !'))
    io.write(luagram_function.colors('\n%{green} password > '))
    local password = io.read()
    function_core.send_tdlib{
      luagram = 'checkAuthenticationPassword',
      password = password
    }
  elseif state.luagram == 'authorizationStateWaitTdlibParameters' or (state.authorization_state and state.authorization_state.luagram == 'authorizationStateWaitTdlibParameters') then
    function_core.send_tdlib{
      luagram = 'setTdlibParameters',
      parameters = luagram.config.parameters
    }
  elseif state.authorization_state and state.authorization_state.luagram == 'authorizationStateWaitEncryptionKey' then
    function_core.send_tdlib{
      luagram = 'checkDatabaseEncryptionKey',
      encryption_key = luagram.config.encryption_key
    }
  elseif state.authorization_state and state.authorization_state.luagram == 'authorizationStateWaitPhoneNumber' then
    if luagram.config.is_bot then
      function_core.send_tdlib{
        luagram = 'checkAuthenticationBotToken',
        token = luagram.config.token
      }
    else
      function_core.send_tdlib{
        luagram = 'setAuthenticationPhoneNumber',
        phone_number = luagram.config.phone
      }
    end
  elseif state.authorization_state and state.authorization_state.luagram == 'authorizationStateWaitCode' then
      io.write(luagram_function.colors('\n%{green} code > '))
      local code = io.read()
      function_core.send_tdlib{
        luagram = 'checkAuthenticationCode',
        code = code
      }
  elseif state.authorization_state and state.authorization_state.luagram == 'authorizationStateWaitPassword' then
      io.write(luagram_function.colors('\n%{green} password [ '..state.authorization_state.password_hint..' ] > '))
      local password = io.read()
      function_core.send_tdlib{
        luagram = 'checkAuthenticationPassword',
        password = password
      }
  elseif state.authorization_state and state.authorization_state.luagram == 'authorizationStateWaitRegistration' then
    io.write(luagram_function.colors('\n%{green} first name > '))
    local first_name = io.read()
    io.write(luagram_function.colors('\n%{green} last name > '))
    local last_name = io.read()
    function_core.send_tdlib{
      luagram = 'registerUser',
      first_name = first_name,
      last_name = last_name
    }
  elseif state.authorization_state and state.authorization_state.luagram == 'authorizationStateReady' then
    print(luagram_function.colors("%{green}>> login successfully let's rock <<"))
  elseif state.authorization_state and state.authorization_state.luagram == 'authorizationStateClosed' then
    print(luagram_function.colors('%{red}>> authorization state closed '))
    luagram.get_update = false
  elseif state.luagram == 'error' and state.message then
    print(luagram_function.colors('%{red}>> '..state.message))
  elseif not (state.luagram and luagram_function.in_array({'updateConnectionState', 'updateSelectedBackground', 'updateConnectionState', 'updateOption', 'ok',}, state.luagram)) then
    return true
  end
end
return luagram
