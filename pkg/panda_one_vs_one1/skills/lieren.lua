local lieren = fk.CreateSkill {
  name = "pang__lieren",
}

Fk:loadTranslationTable{
  ["pang__lieren"] = "烈刃",
  [":pang__lieren"] = "准备阶段，你可以使用弃牌堆内的一张火【杀】，然后令对手获得之。",
  ["#pang__lieren"] = "烈刃：你可以使用弃牌堆内一张火【杀】，然后对手获得之",

  ["$pang__lieren1"] = "哼！可知本夫人厉害？",
  ["$pang__lieren2"] = "我的飞刀，谁敢小瞧？",
}



lieren:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    local cards = table.filter(player.room.discard_pile, function (id)
        local card = Fk:getCardById(id)
        return card.name == "fire__slash"
    end)
    return #cards > 0 and target == player and player:hasSkill(lieren.name) and target.phase == Player.Start
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local cards = table.filter(player.room.discard_pile, function (id)
        local card = Fk:getCardById(id)
        return card.name == "fire__slash"
    end)
    local use = room:askToUseRealCard(player, {
                    pattern = tostring(Exppattern{ id = cards }),
                    expand_pile = cards,
                    skill_name = lieren.name,
                    prompt = "#pang__lieren",
                    extra_data = {
                        bypass_times = true,
                        extraUse = true,
                        expand_pile = cards,
                    }
                })
    if use then
        event:setCostData(self, {card = use.card})
        return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local get = event:getCostData(self).card
    room:obtainCard(player.next, get, false, fk.ReasonJustMove, player, lieren.name)
  end,
})



return lieren