local eyao = fk.CreateSkill {
  name = "pang__eyao",
}

Fk:loadTranslationTable{
  ["pang__eyao"] = "扼要",
  [":pang__eyao"] = "每轮开始时，你可以声明一个不大于4的正整数；当对手本轮使用第X张牌后，你可以对其造成1点伤害（X为你选择的数字），然后其本轮使用牌时摸一张牌。",

  ["#eyao_show"] = "扼要：你可以选择一个不大于4的正整数",
  [ "#eyao_choice"] = "扼要：选择一个数字",
  ["@pang__eyao_count-round"] = "扼要",
  ["#eyao_use"] = "扼要：你可以对 %src 造成1点伤害，然后其本轮使用牌时摸一张牌",
  ["#eyao_touse"] = "扼要：你可以使用一张牌",


  ["$pang__eyao1"] = "善战者后动，一击而毙敌。",
  ["$pang__eyao2"] = "我所善者，后发制人尔。",
}



eyao:addEffect(fk.RoundStart,{
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(eyao.name) 
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#eyao_show",
      skill_name = eyao.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local choices = {"1","2","3","4"}
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = eyao.name,
      prompt = "#eyao_choice",
    })
    if choice == "1" then
        choice = 1
    elseif choice == "2" then
        choice = 2
    elseif choice == "3" then
        choice = 3
    elseif choice == "4" then
        choice = 4
    end
    room:setPlayerMark(player,"@pang__eyao_count-round", choice)
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
    return player.room:askToSkillInvoke(player,{
      prompt = "#eyao_use:"..player.next.id,
      skill_name = eyao.name,
    })
  end,
    on_use = function(self, event, target, player, data)
        local room = player.room
        room:damage{
            from = player,
            to = player.next,
            damage = 1,
            skillName = eyao.name,
        }
        room:setPlayerMark(player,"@pang__eyao_count-round", 0)
        room:setPlayerMark(player.next,"pang__eyao_use-round", 1)
    end,
})

eyao:addEffect(fk.CardUsing, {
    anim_type = "drawcard",
    can_refresh = function(self, event, target, player, data)
        return target == player and player:getMark("pang__eyao_use-round") > 0
    end,
    on_refresh = function(self, event, target, player, data)
        player:drawCards(1, eyao.name)
    end,
})

return eyao