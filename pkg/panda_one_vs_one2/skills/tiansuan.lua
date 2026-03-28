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
    local judge = {
      who = player,
      reason = tiansuan.name,
      pattern = {
        [".|.|spade,club,diamond"] = "good",
        [".|.|spade"] = "spade",
        [".|.|club"] = "club",
        [".|.|diamond"] = "diamond",
        ["else"] = "bad"
      },
    }
    player:broadcastSkillInvoke(tiansuan.name, 2)
    room:judge(judge)
    local suit1
    local suit2
    if not player.dead and judge.results then
        if table.contains(judge.results, "diamond") then
            suit1 = "diamond"
        elseif table.contains(judge.results, "club") or table.contains(judge.results, "spade") then
            suit1 = "black"
        end
    end
    room:judge(judge)
    if not player.dead and judge.results then
        if table.contains(judge.results, "diamond") then
            suit2 = "diamond"
        elseif table.contains(judge.results, "club") or table.contains(judge.results, "spade") then
            suit2 = "black"
        end
    end
    if suit1 and suit2 then
        if suit1 == "diamond" and suit2 == "diamond" then
            player:drawCards(2, tiansuan.name)
            player:broadcastSkillInvoke(tiansuan.name, 1)
        elseif suit1 == "black" and suit2 == "black" then
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