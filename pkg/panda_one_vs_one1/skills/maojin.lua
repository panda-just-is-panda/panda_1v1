local qingbei = fk.CreateSkill{
  name = "pang__maojin",
  tags = {  },
}

Fk:loadTranslationTable {
  ["pang__maojin"] = "冒进",
  [":pang__maojin"] = "出牌阶段限一次，你可以令对手摸两至四张牌，然后你视为使用一张伤害牌；若你因此造成伤害，你摸等量张牌。",

  ["#pang__maojin"] = "冒进：令对手摸两至四张牌，然后视为使用任意伤害牌，若造成伤害则你摸等量张牌",

  ["$pang__maojin1"] = "待追上那司马懿，定教他没好果子吃！",
  ["$pang__maojin2"] = "身若不周，吾一人可作擎北之柱。",
}

qingbei:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#pang__maojin",
  card_num = 0,
  target_num = 0,
  interaction = function(self, player)
    return UI.Spin {
      from = 2,
      to = 4,
    }
  end,
  can_use = function(self, player)
    return player:usedSkillTimes(qingbei.name, Player.HistoryPhase) == 0
  end,
  card_filter = Util.FalseFunc,
  on_use = function(self, room, effect)
    local player = effect.from
    local to = player.next
    local to_draw = self.interaction.data
    to:drawCards(to_draw, qingbei.name)
    local names = table.filter(Fk:getAllCardNames("bt"), function (name)
        local card = Fk:cloneCard(name)
        card.skillName = qingbei.name
        return card.is_damage_card and not player:prohibitUse(card) and player:canUse(card)
    end)
    if #names > 0 then
        room:askToUseVirtualCard(player, {
            name = names, skill_name = qingbei.name, cancelable = false, skip = false,extra_data = {
              bypass_times = false,
              extraUse = false,
            }
        })
    end
    if player:getMark("maojin_damage") > 0 then
        player:drawCards(to_draw, qingbei.name)
        room:setPlayerMark(player, "maojin_damage", 0)
    end
  end,
})

qingbei:addEffect(fk.Damage, {
  can_refresh = function(self, event, target, player, data)
    return target == player and data.card and table.contains(data.card.skillNames, qingbei.name)
  end,
  on_refresh = function(self, event, target, player, data)
      player.room:addPlayerMark(player, "maojin_damage", 1)
  end,
})



return qingbei