local yicheng = fk.CreateSkill {
  name = "pang__yicheng",
}

Fk:loadTranslationTable{
  ["pang__yicheng"] = "疑城",
  [":pang__yicheng"] = "出牌阶段限一次，你可以摸X张牌（X为你的手牌数）并展示任意张手牌，然后对手选择一项：弃置你所有因此展示的手牌；弃置你所有未因此展示的手牌。",
  ["#pang__yicheng"] = "疑城：你可以摸%src张牌并展示任意张手牌",
  ["#yicheng_show"] = "疑城：展示任意张手牌",
  ["discard_show"] = "弃置对手展示的牌",
  ["discard_not_show"] = "弃置对手未展示的牌",

  ["$pang__yicheng1"] = "不怕死，就尽管放马过来！",
  ["$pang__yicheng2"] = "待末将布下疑城，以退曹贼。",
}

yicheng:addEffect("active", {
  anim_type = "offensive",
  prompt = function(self, player)
    return "#pang__yicheng:"..#player:getCardIds("h")
  end,
  max_phase_use_time = 1,
  card_num = 0,
  target_num = 0,
  can_use = function(self, player)
    return not player:isKongcheng() and not player.next:isKongcheng()
    and player:usedSkillTimes(yicheng.name, Player.HistoryPhase) == 0
  end,
  card_filter = Util.FalseFunc,
  target_filter = Util.FalseFunc,
  on_use = function(self, room, effect)
    local player = effect.from
    local to = player.next
    player:drawCards(#player:getCardIds("h"), yicheng.name)
    local cards = room:askToCards(player, {
      min_num = 0,
      max_num = 999,
      include_equip = false,
      skill_name = yicheng.name,
      prompt = "#yicheng_show",
      cancelable = false,
    })
    local cards2 = table.filter(player:getCardIds("h"), function (id)
        return not table.contains(cards, id)
    end)
    if #cards > 0 then
        player:showCards(cards)
    end
    local choices = {"discard_show", "discard_not_show"}
    local choice = room:askToChoice(to, {
      choices = choices,
      skill_name = yicheng.name,
    })
    if choice == "discard_show" and #cards > 0 then
        room:throwCard(cards, yicheng.name, player, to)
    elseif choice == "discard_not_show" and #cards2 > 0 then
        room:throwCard(cards2, yicheng.name, player, to)
    end
  end,
})



return yicheng