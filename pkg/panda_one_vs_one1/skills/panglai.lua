local panglai = fk.CreateSkill {
  name = "pang__panglai",
}

Fk:loadTranslationTable{
  ["pang__panglai"] = "胖来",
  [":pang__panglai"] = "当胖登场时，将所有胖胖扩的武将加入你的备选武将，然后你变更武将。",
  ["#pang__panglai"] = "胖来：变更为一个胖胖武将",

}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

panglai:addEffect(U.AfterDebut, {
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(panglai.name)
  end,
  on_cost = Util.TrueFunc,
  on_use = function (self, event, target, player, data)
    local room = player.room
    player:chat("爱胖，太好")
    room:animDelay(2)
    if player:usedSkillTimes(panglai.name, Player.HistoryGame) == 1 then
      player:chat("胖本体好像是白板")
      room:animDelay(2)
      player:chat("还是玩点别的吧～")
    elseif player:usedSkillTimes(panglai.name, Player.HistoryGame) == 2 then
      player:chat("何故还在选白板胖")
      room:animDelay(2)
      player:chat("速速换将")
    elseif player:usedSkillTimes(panglai.name, Player.HistoryGame) == 3 then
      player:chat("居然对胖如此之爱")
      room:animDelay(2)
      player:chat("太泪目")
    end
    local pang__general = {"pang__yangyi", "pang__weiyan", "pang__sunshangxiang", "pang__zhoushan", "pang__jiakui",
    "pang__zangba", "pang__wangyun", "pang__zhurong", "pang__wangyuanji", "pang__wangjun"}
    for _, general in ipairs(pang__general) do
      local list1 = U.getGenerals(player)
      local list2 = U.getGenerals(player.next)
      local list3 = U.getGenerals(player,"dead")
      local list4 = U.getGenerals(player.next,"dead")
      local list5 = {player.general, player.next.general}
      local matching1 = table.filter(list1,function (element, index, array)
        return Fk.generals[element].name == general
      end)
      local matching2 = table.filter(list2,function (element, index, array)
        return Fk.generals[element].name == general
      end)
      local matching3 = table.filter(list3,function (element, index, array)
        return Fk.generals[element].name == general
      end)
      local matching4 = table.filter(list4,function (element, index, array)
        return Fk.generals[element].name == general
      end)
      local matching5 = table.filter(list5,function (element, index, array)
        return Fk.generals[element].name == general
      end)
      if #matching1 == 0 and #matching2 == 0 and #matching3 == 0 and #matching4 == 0 and #matching5 == 0 then
        U.addGeneral(player,general, {state = "alive"})
      end
    end
    local listall = U.getGenerals(player)
    local not_available = {}
    U.AskToChangeGeneral(player,panglai.name,listall,not_available)
  end,
})

return panglai