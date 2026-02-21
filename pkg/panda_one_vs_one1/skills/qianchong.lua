local qianchong = fk.CreateSkill {
  name = "pang__qianchong",
}

qianchong:addEffect(fk.CardUsing, {
    mute = true,
  can_trigger = function(self, event, target, player, data)
    if target == player and data.card then
      if data.card.trueName == "slash" then
        player.room:setPlayerMark(player, "qianchong_slash", 1)
      elseif data.card.type == Card.TypeTrick then
        player.room:setPlayerMark(player, "qianchong_trick", 1)
      end
    end
    return target == player.next and data.card and player:hasSkill(qianchong.name) and
    (data.card.trueName == "slash" and player:getMark("@@qianchong_slashbuff-round") == 1
    or data.card.type == Card.TypeTrick and player:getMark("@@qianchong_trickbuff-round") == 1 and not player.next:isNude())
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
    prompt = data.card.trueName == "slash" and "#pang__qianchong_slash" or "#pang__qianchong_trick",
    skill_name = qianchong.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if data.card.type == Card.TypeTrick then
      player:drawCards(1, qianchong.name)
      player:broadcastSkillInvoke(qianchong.name, 2)
    else
      player:broadcastSkillInvoke(qianchong.name, 1)
      local discarding = room:askToChooseCards(player, {
          target = player.next,
          min = 1,
          max = 1,
          flag = "he",
          skill_name = qianchong.name,
          prompt = "#pang__qianchong_select",
        })
      if #discarding > 0 then
          local cards = discarding
          room:throwCard(cards, qianchong.name, player.next, player) 
      end
    end
  end,
})

qianchong:addEffect(fk.RoundStart,{
  can_refresh = function (self, event, target, player, data)
    return player:hasSkill(qianchong.name,true) and player.room:getBanner("RoundCount") > 1
  end,
  on_refresh = function (self, event, target, player, data)
    local room = player.room
    if player:getMark("qianchong_slash") == 0 then
      room:setPlayerMark(player, "@@qianchong_slashbuff-round", 1)
    end
    if player:getMark("qianchong_trick") == 0 then
      room:setPlayerMark(player, "@@qianchong_trickbuff-round", 1)
    end
    room:setPlayerMark(player, "qianchong_slash", 0)
    room:setPlayerMark(player, "qianchong_trick", 0)
  end,
})

Fk:loadTranslationTable {["pang__qianchong"] = "谦冲",
[":pang__qianchong"] = "若你上轮未使用过：【杀】，对手使用【杀】时你可以弃置其一张牌；锦囊牌，对手使用锦囊牌时你可以摸一张牌。",


["#pang__qianchong_slash"] = "谦冲：你可以弃置对手一张牌",
["#pang__qianchong_trick"] = "谦冲：你可以摸一张牌",
["#pang__qianchong_select"] = "谦冲：弃置对手一张牌",
["@@qianchong_slashbuff-round"] = "谦冲：杀",
["@@qianchong_trickbuff-round"] = "谦冲：锦囊",


["$pang__qianchong1"] = "谦谨行事，方能多吉少恙。",
  ["$pang__qianchong2"] = "宫闱之内，何必擅摄外事。",
}

return qianchong