local jianglve = fk.CreateSkill{
  name = "pang__jianglve",
  tags = {},
}

Fk:loadTranslationTable{
  ["pang__jianglve"] = "将略",
  [":pang__jianglve"] = "摸牌阶段开始时，若你没有“略”，你可以摸六张牌并将六张手牌扣置于武将牌上，称为“略”，否则此阶段改为你获得两张“略”。",

  ["#pang__jianglve"] = "将略：你可以摸六张牌并将六张牌扣置于武将牌上，称为“略”",
  ["#pang__jianglve_making_lve"] = "将略：将六张牌扣置于武将牌上，称为“略”",
  ["#pang__jianglve_using"] = "将略：获得两张“略”",
  ["$pang__wangping_lve"] = "略",


  ["$pang__jianglve1"] = "奇谋为短，将略为要。",
  ["$pang__jianglve2"] = "为将者，需有谋略。",
}

jianglve:addEffect(fk.EventPhaseStart, {
  mute = true,
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jianglve.name)
    and player.phase == Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
    if #player:getPile("$pang__wangping_lve") > 0 then
        return true
    else
        return player.room:askToSkillInvoke(player,{
            prompt = "#pang__jianglve",
            skill_name = jianglve.name,
        })
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    if #player:getPile("$pang__wangping_lve") > 0 then
        data.phase_end = true
        local card = room:askToCards(player, {
            min_num = 2,
            max_num = 2,
            include_equip = false,
            skill_name = jianglve.name,
            pattern = ".|.|.|$pang__wangping_lve",
            prompt = "#pang__jianglve_using",
            cancelable = false,
            expand_pile = "$pang__wangping_lve",
        })
        room:moveCardTo(card, Card.PlayerHand, player, fk.ReasonJustMove, jianglve.name, nil, true, player)
    else
        player:drawCards(6, jianglve.name)
        local card = room:askToCards(player, {
            min_num = 6,
            max_num = 6,
            include_equip = false,
            skill_name = jianglve.name,
            cancelable = false,
            prompt = "#pang__jianglve_making_lve",
        })
        player:addToPile("$pang__wangping_lve", card, true, jianglve.name)
    end
  end,
})


return jianglve