local tiansuan = fk.CreateSkill {
  name = "pang__tiansuan",
}

Fk:loadTranslationTable{
  ["pang__tiansuan"] = "天算",
  [":pang__tiansuan"] = "出牌阶段限一次，你可以依次进行两次判定，然后若判定结果均为：方块，你摸两张牌；黑色，你弃置对手一张牌。",
  ["#pang__tiansuan"] = "天算：你可以进行两次判定，根据判定结果触发对应效果",

  ["$pang__tiansuan1"] = "雷霆雨露，皆为君恩。",
  ["$pang__tiansuan2"] = "天象之所显，世事之所为。",
}

tiansuan:addEffect("active", {
  anim_type = "offensive",
  mute = true,
  prompt = "#pang__tiansuan",
  max_phase_use_time = 1,
  card_num = 0,
  target_num = 0,
  can_use = function(self, player)
    return player:usedSkillTimes(tiansuan.name, Player.HistoryPhase) == 0
  end,
  card_filter = Util.FalseFunc,
  target_filter = Util.FalseFunc,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = player.next
    local judge1 = {
      who = player,
      reason = tiansuan.name,
      pattern = {
        [".|.|^diamond"] = "good",
        [".|.|black"] = "bad"
      },
    }
    local judge2 = {
      who = player,
      reason = tiansuan.name,
      pattern = ".|.|^nosuit",
    }
    player:broadcastSkillInvoke(tiansuan.name, 1)
    room:judge(judge1)
    room:judge(judge2)
    if not player.dead and judge1.results and judge2.results then
        if table.contains(judge1.results, "diamond") and table.contains(judge2.results, "diamond") then
            player:drawCards(2, tiansuan.name)
            player:broadcastSkillInvoke(tiansuan.name, 2)
        elseif table.contains(judge1.results, "club") and table.contains(judge2.results, "club") and not target:isNude() then
            local card = room:askToChooseCard(player, {
                target = target,
                skill_name = tiansuan.name,
                flag = "he",
            })
            room:throwCard(card, tiansuan.name, target, player)
        elseif table.contains(judge1.results, "spade") and table.contains(judge2.results, "spade") and not target:isNude() then
            local card = room:askToChooseCard(player, {
                target = target,
                skill_name = tiansuan.name,
                flag = "he",
            })
            room:throwCard(card, tiansuan.name, target, player)
        end
    end
  end,
})





return tiansuan