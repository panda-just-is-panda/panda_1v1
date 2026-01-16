

local xibing = fk.CreateSkill {
  name = "pang__xibing",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["pang__xibing"] = "息兵",
  [":pang__xibing"] = "锁定技，本轮未使用过【杀】的角色的手牌上限+2。",

  ["$pang__xibing1"] = "千里运粮，非用兵之利。",
  ["$pang__xibing2"] = "宜弘一代之治，绍三王之迹。",
}

xibing:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:getMark("xibing__use-round") == 0 then
        return 2
    end
  end,
})

xibing:addAcquireEffect(function(self, player, is_start)
    if not is_start then
        local room = player.room
        for _, p in ipairs(Fk:currentRoom().alive_players) do
            room.logic:getEventsOfScope(GameEvent.UseCard, 1, function(e)
                local use = e.data
                if use.from == p and use.card.trueName == "slash" then
                    room:setPlayerMark(p, "xibing__use-round", 1)
                end
            end, Player.HistoryRound)
        end
    end
end)

xibing:addEffect(fk.CardUsing, {
  can_refresh = function(self, event, target, player, data)
    return target == player and data.card and data.card.trueName == "slash"
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:setPlayerMark(p, "xibing__use-round", 1)
  end,
})

return xibing