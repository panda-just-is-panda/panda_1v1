local aorui = fk.CreateSkill {
  name = "pang__aorui",
}

aorui:addEffect(fk.CardUsing, {
    mute = true,
  can_refresh = function(self, event, target, player, data)
    return target == player and data.card and player:hasSkill(aorui.name)
    and (data.card.trueName == "slash" or data.card.trueName == "jink")
  end,
  on_refresh = function (self, event, target, player, data)
    local room = player.room
    if data.card.trueName == "slash" then
        room:setPlayerMark(player, "aorui__used_slash", 1)
    elseif data.card.trueName == "jink" then
        room:setPlayerMark(player, "aorui__used_jink", 1)
    end
  end,
})

aorui:addEffect(fk.RoundStart,{
  can_refresh = function (self, event, target, player, data)
    return player:hasSkill(aorui.name) and player.room:getBanner("RoundCount") > 1
  end,
  on_refresh = function (self, event, target, player, data)
    local room = player.room
    if player:getMark("aorui__used_slash") > 0 and player:getMark("aorui__used_jink") == 0 then
        room:setPlayerMark(player, "@@pang__aorui_success-round", 1)
    else
        room:setPlayerMark(player, "@@pang__aorui_fail-round", 1)
    end
    room:setPlayerMark(player, "aorui__used_jink", 0)
    room:setPlayerMark(player, "aorui__used_slash", 0)
  end,
})

aorui:addEffect(fk.DrawNCards, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(aorui.name) and
    player:getMark("@@pang__aorui_success-round") == 1
  end,
    on_cost = function (self, event, target, player, data)
    return true
  end,
  on_use = function(self, event, target, player, data)
    data.n = data.n + 1
  end,
})


aorui:addEffect("viewas", {
  anim_type = "offensive",
  mute_card = true,
  pattern = "slash",
  prompt = "#pang__aorui",
  filter_pattern = function (self, player, card_name)
    local cards = player:getCardIds("h")
    return {
      max_num = #cards,
      min_num = #cards,
      pattern = ".|.|.|hand",
      subcards = cards
    }
  end,
  card_filter = Util.FalseFunc,
  view_as = function(self, player, cards)
    if #cards < 1 then return end
    local c = Fk:cloneCard("slash")
    c:addSubcards(player:getCardIds("h"))
    c.skillName = aorui.name
    return c
  end,
  enabled_at_play = function(self, player)
    return not player:isKongcheng()
  end,
  enabled_at_response = function(self, player, response)
    return not response and not player:isKongcheng()
  end,
})

Fk:loadTranslationTable {["pang__aorui"] = "鏖锐",
[":pang__aorui"] = "若你上轮使用过【杀】且未使用过【闪】，你的摸牌阶段多摸一张牌；否则，你可以将所有手牌作为【杀】使用。",

["#pang__aorui"] = "鏖锐：将所有手牌作为【杀】使用",
["@@pang__aorui_success-round"] = "鏖锐：多摸牌",
["@@pang__aorui_fail-round"] = "鏖锐：转化杀",


["$pang__qianchong1"] = "背水一战，将至绝地而何畏死。",
  ["$pang__qianchong2"] = "破釜沉舟，置之死地而后生。",
}

return aorui