local gangshou = fk.CreateSkill {
  name = "pang__gangshou",
}

Fk:loadTranslationTable{
  ["pang__gangshou"] = "刚守",
  [":pang__gangshou"] = "当对手使用的指定了你为目标的牌结算后，你可以将一张类型相同的牌作为【万箭齐发】使用。",
  ["#pang__gangshou"] = "刚守：你可以将一张类型不同的牌当【万箭齐发】使用",


  ["$pang__gangshou1"] = "敌军攻势渐怠，还望诸位依策坚守。",
  ["$pang__gangshou2"] = "袁幽州不日便至，当行策建功以报之。",
}



gangshou:addEffect(fk.CardUseFinished, {
    anim_type = "drawcard",
    can_trigger = function(self, event, target, player, data)
        return player:hasSkill(gangshou.name) and target == player.next 
        and data.tos and table.contains(data.tos, player)
        and #player:getCardIds("he") > 0
    end,
    on_cost = function (self, event, target, player, data)
        local room = player.room
        local type = data.card.type
        local cards = table.filter(player:getCardIds("he"), function(id)
            local card = Fk:getCardById(id)
            return card and card.type == type
        end)
        local card = room:askToCards(player, {
                min_num = 1,
                max_num = 1,
                include_equip = true,
                prompt = "#pang__gangshou",
                pattern = tostring(Exppattern{ id = cards }),
                skill_name = gangshou.name,
                cancelable = true,
            })
        if #card > 0 then
            event:setCostData(self, {card = card})
        end
  end,
    on_use = function(self, event, target, player, data)
        local room = player.room
        local subcard = event:getCostData(self).card
        local archery_attack = Fk:cloneCard("archery_attack")
        archery_attack:addSubcards(subcard)
        room:useVirtualCard("archery_attack", archery_attack, player.next, player, gangshou.name, true)
    end,
})

return gangshou