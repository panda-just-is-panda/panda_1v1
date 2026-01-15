

local xibing = fk.CreateSkill {
  name = "pang__xibing",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["pang__xibing"] = "息兵",
  [":pang__xibing"] = "锁定技，本轮未使用过【杀】的角色的手牌上限+2。",

}

xibing:addEffect("maxcards", {
  correct_func = function(self, player)
    local room = player.room
    local num = 0
    room.logic:getEventsOfScope(GameEvent.UseCard, 1, function(e)
      local use = e.data
      if use.from == player and use.card.trueName == "slash" then
        num = num + 1
      end
    end, Player.HistoryRound)
    if num == 0 then
        return 2
    end
  end,
})