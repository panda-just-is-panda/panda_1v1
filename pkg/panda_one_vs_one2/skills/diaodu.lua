local diaodu = fk.CreateSkill {
  name = "pang__diaodu",
}

Fk:loadTranslationTable{
  ["pang__diaodu"] = "调度",
  [":pang__diaodu"] = "当你登场后，你选择未选择过的一项：手牌上限+1；摸两张牌；视为使用【杀】。且此后登场的我方角色也如此做。",
  ["#pang__duodao"] = "调度：选择未选择过的一项",
  ["pang__diaodu_maxcard"] = "手牌上限+1",
  ["pang__diaodu_slash"] = "视为使用【杀】",
  ["pang__diaodu_draw"] = "摸两张牌",

  ["$pang__diaodu1"] = "诸军兵器战具，皆由我调配。",
  ["$pang__diaodu2"] = "甲胄兵器，按我所说之法分发。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

diaodu:addEffect(U.AfterDebut,{
  can_trigger = function (self, event, target, player, data)
    if player:hasSkill(diaodu.name) and player:usedSkillTimes(diaodu.name, Player.HistoryGame) == 0 then
        player.room:setBanner(diaodu.name..player.role, 0)
    end
    return target == player and not data.begingame
    and (player:hasSkill(diaodu.name) or player:usedSkillTimes(diaodu.name, Player.HistoryGame) > 0)
    and player.room:getBanner(diaodu.name..player.role) ~= 7
  end,
  on_cost = Util.TrueFunc,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local choices = {"pang__diaodu_maxcard","pang__diaodu_slash","pang__diaodu_draw"}
    if player.room:getBanner(diaodu.name..player.role) == 1 then
        choices = {"pang__diaodu_slash","pang__diaodu_draw"}
    elseif player.room:getBanner(diaodu.name..player.role) == 2 then
        choices = {"pang__diaodu_maxcard","pang__diaodu_draw"}
    elseif player.room:getBanner(diaodu.name..player.role) == 3 then
        choices = {"pang__diaodu_maxcard","pang__diaodu_slash"}
    elseif player.room:getBanner(diaodu.name..player.role) == 4 then
        choices = {"pang__diaodu_maxcard"}
    elseif player.room:getBanner(diaodu.name..player.role) == 5 then
        choices = {"pang__diaodu_slash"}
    elseif player.room:getBanner(diaodu.name..player.role) == 6 then
        choices = {"pang__diaodu_draw"}
    end
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = diaodu.name,
    })
    if choice == "pang__diaodu_maxcard" then
        room:addPlayerMark(player, MarkEnum.AddMaxCards)
        if #choices == 3 then
            room:setBanner(diaodu.name..player.role, 1)
        elseif room:getBanner(diaodu.name..player.role) == 2 then
            room:setBanner(diaodu.name..player.role, 6)
        elseif room:getBanner(diaodu.name..player.role) == 3 then
            room:setBanner(diaodu.name..player.role, 5)
        else
            room:setBanner(diaodu.name..player.role, 7)
        end
    elseif choice == "pang__diaodu_slash" then
        room:askToUseVirtualCard(player, {name = "slash", skill_name = diaodu.name, cancelable = false, skip = false})
        if #choices == 3 then
            room:setBanner(diaodu.name..player.role, 2)
        elseif room:getBanner(diaodu.name..player.role) == 1 then
            room:setBanner(diaodu.name..player.role, 6)
        elseif room:getBanner(diaodu.name..player.role) == 3 then
            room:setBanner(diaodu.name..player.role, 4)
        else
            room:setBanner(diaodu.name..player.role, 7)
        end
    elseif choice == "pang__diaodu_draw" then
        player:drawCards(2, diaodu.name)
        if #choices == 3 then
            room:setBanner(diaodu.name..player.role, 3)
        elseif room:getBanner(diaodu.name..player.role) == 1 then
            room:setBanner(diaodu.name..player.role, 5)
        elseif room:getBanner(diaodu.name..player.role) == 2 then
            room:setBanner(diaodu.name..player.role, 4)
        else
            room:setBanner(diaodu.name..player.role, 7)
        end
    end
  end,
})




return diaodu