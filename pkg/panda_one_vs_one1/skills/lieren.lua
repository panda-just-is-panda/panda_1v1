local lieren = fk.CreateSkill {
  name = "pang__lieren",
}

Fk:loadTranslationTable{
  ["pang__lieren"] = "烈刃",
  [":pang__lieren"] = "出牌阶段限一次，你可以和对手拼点，然后赢的角色和拼点牌为【杀】的角色依次视为使用一张【杀】。",
  ["#pang__lieren"] = "烈刃：你可以和对手拼点，然后赢的角色和拼点牌为【杀】的角色依次视为使用一张【杀】",

  ["$pang__lieren1"] = "哼！可知本夫人厉害？",
  ["$pang__lieren2"] = "我的飞刀，谁敢小瞧？",
}

lieren:addEffect("active", {
  anim_type = "offensive",
  prompt = "#pang__lieren",
  max_phase_use_time = 1,
  card_num = 0,
  target_num = 0,
  can_use = function(self, player)
    return not player:isKongcheng() and not player.next:isKongcheng()
    and player:usedSkillTimes(lieren.name, Player.HistoryPhase) == 0
  end,
  card_filter = Util.FalseFunc,
  target_filter = Util.FalseFunc,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = player.next
    local pindian = player:pindian({target}, lieren.name)
    if pindian.results[target].winner == player and not player.dead then
      room:askToUseVirtualCard(player, {name = "slash", skill_name = lieren.name, cancelable = false, skip = false})
    elseif pindian.results[target].winner == target and not target.dead then
      room:askToUseVirtualCard(target, {name = "slash", skill_name = lieren.name, cancelable = false, skip = false})
    end
    if pindian.fromCard.trueName == "slash" and not player.dead then
      room:askToUseVirtualCard(player, {name = "slash", skill_name = lieren.name, cancelable = false, skip = false})
    end
    if pindian.results[target].toCard.trueName == "slash" and not target.dead then
      room:askToUseVirtualCard(target, {name = "slash", skill_name = lieren.name, cancelable = false, skip = false})
    end
  end,
})





return lieren