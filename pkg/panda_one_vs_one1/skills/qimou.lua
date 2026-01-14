local qimou = fk.CreateSkill{
  name = "pang__qimou",
  tags = {  },
}

Fk:loadTranslationTable {
  ["pang__qimou"] = "奇谋",
  [":pang__qimou"] = "出牌阶段限一次，你可以令对手摸两至四张牌，然后你视为使用一张伤害牌；若你因此造成伤害，你摸等量张牌。",

  ["#pang__qimou"] = "奇谋：令对手摸两至四张牌，然后视为使用任意伤害牌，若造成伤害则你摸等量张牌",

  ["$pang__qimou1"] = "轻兵出子午，直取魏王都。",
  ["$pang__qimou2"] = "哼，丞相奇谋为短，吾以涉险为长！",
}

qimou:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#pang__qimou",
  card_num = 0,
  target_num = 0,
  interaction = function(self, player)
    return UI.Spin {
      from = 2,
      to = 4,
    }
  end,
  can_use = function(self, player)
    return player:usedSkillTimes(qimou.name, Player.HistoryPhase) == 0
  end,
  card_filter = Util.FalseFunc,
  on_use = function(self, room, effect)
    local player = effect.from
    local to = player.next
    local to_draw = self.interaction.data
    to:drawCards(to_draw, qimou.name)
    local names = table.filter(Fk:getAllCardNames("bt"), function (name)
        local card = Fk:cloneCard(name)
        card.skillName = qimou.name
        return card.is_damage_card and not player:prohibitUse(card) and player:canUse(card)
    end)
    if #names > 0 then
        room:askToUseVirtualCard(player, {
            name = names, skill_name = qimou.name, cancelable = false, skip = false,
        })
    end
    if player:getMark("qimou_damage") > 0 then
        player:drawCards(to_draw, qimou.name)
        room:setPlayerMark(player, "qimou_damage", 0)
    end
  end,
})

qimou:addEffect(fk.Damage, {
  can_refresh = function(self, event, target, player, data)
    return target == player and data.card and table.contains(data.card.skillNames, qimou.name)
  end,
  on_refresh = function(self, event, target, player, data)
      player.room:addPlayerMark(player, "qimou_damage", 1)
  end,
})



return qimou