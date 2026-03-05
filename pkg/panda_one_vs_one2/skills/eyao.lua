local eyao = fk.CreateSkill {
  name = "pang__eyao",
}

Fk:loadTranslationTable{
  ["pang__eyao"] = "扼要",
  [":pang__eyao"] = "每轮开始时，你可以展示任意张手牌；当对手本轮使用第X张牌后，你观看牌堆顶的X张牌并可以使用其中一张牌或一张因此展示的牌（X为你展示的牌数）。",

  ["#eyao_show"] = "扼要：你可以展示任意张手牌",
  ["@@pang__eyao-round"] = "扼要",
  ["@pang__eyao_count-round"] = "扼要",
  ["#eyao_use"] = "扼要：你可以观看牌堆顶的%dest张牌并使用其中一张或一张本轮展示的手牌",
  ["#eyao_touse"] = "扼要：你可以使用一张牌",


  ["$pang__eyao1"] = "善战者后动，一击而毙敌。",
  ["$pang__eyao2"] = "我所善者，后发制人尔。",
}



eyao:addEffect(fk.RoundStart,{
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(eyao.name) 
    and not player:isKongcheng()
  end,
  on_cost = function (self, event, target, player, data)
    local cards = player.room:askToCards(player, {
      skill_name = eyao.name,
      min_num = 1,
      max_num = player:getHandcardNum(),
      prompt = "#eyao_show",
    })
    if #cards > 0 then
        player:showCards(cards)
      event:setCostData(self, {cards = cards})
      return true
    end  
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local X = #event:getCostData(self).cards
    room:setPlayerMark(player,"@pang__eyao_count-round", X)
    for _, id in ipairs(event:getCostData(self).cards) do
      room:setCardMark(Fk:getCardById(id), "@@pang__eyao-round", 1)
    end
    player:filterHandcards()
  end,
})

eyao:addEffect(fk.CardUseFinished, {
    anim_type = "offensive",
    can_trigger = function(self, event, target, player, data)
        local X = player:getMark("@pang__eyao_count-round")
        local used_num = #player.room.logic:getEventsOfScope(GameEvent.UseCard, 999, function(e)
        return e.data.from == player.next
      end, Player.HistoryRound)
        return player:hasSkill(eyao.name) and target == player.next and used_num == X
    end,
    on_cost = function (self, event, target, player, data)
    local X = player:getMark("@pang__eyao_count-round")
    return player.room:askToSkillInvoke(player,{
      prompt = "#eyao_use::"..X,
      skill_name = eyao.name,
    })
  end,
    on_use = function(self, event, target, player, data)
        local room = player.room
        local X = player:getMark("@pang__eyao_count-round")
        local cards = room:getNCards(X)
        for _, id in ipairs(player:getCardIds("h")) do
            if Fk:getCardById(id):getMark("@@pang__eyao-round") > 0 then
                table.insertIfNeed(cards, id)
            end
        end
        local use = room:askToUseRealCard(player, {
            pattern = tostring(Exppattern{ id = cards }),
            skill_name = eyao.name,
            prompt = "#eyao_touse",
            extra_data = {
                bypass_times = true,
                extraUse = true,
                expand_pile = cards,
            },
            skip = true
        })
        if use then
            use.extraUse = true
            room:useCard(use)
        end
    end,
})

return eyao