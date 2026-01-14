local jushou = fk.CreateSkill {
  name = "pang__jushou",
}

Fk:loadTranslationTable{
  ["pang__jushou"] = "据守",
  [":pang__jushou"] = "你连续四轮未对对手使用牌后，你摸三张牌或令你的最大登场数+1。",
  ["@pang__jushou"] = "据守",
  ["jushou_draw"] = "摸三张牌",
  ["jushou_yuanjun"] = "最大登场数+1",

  ["$pang__jushou1"] = "白马沉河共歃誓，怒涛没城亦不悔！",
  ["$pang__jushou2"] = "山水速疾来去易，襄樊镇固永难开！",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

jushou:addEffect(fk.RoundEnd,{
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(jushou.name,true)
  end,
  on_cost = function (self, event, target, player, data)
    local n = player:getMark("@pang__jushou")
    if player:getMark("@pang__jushou_restrict-round") == 0 then
      n = n + 1
    else
      n = 0
    end
    if n >= 4 and player:hasSkill(jushou.name) then
      player.room:setPlayerMark(player,"@pang__jushou", 0)
      return true
    else
        player.room:setPlayerMark(player,"@pang__jushou", n)
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local choices = {"jushou_draw", "jushou_yuanjun"}
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = jushou.name,
      })
    if choice == "jushou_draw" then
        player:drawCards(3, jushou.name)
    else
       U.addPlayercount(player,0,1)
    end
  end,
})

jushou:addEffect(fk.TargetSpecifying, {
  anim_type = "offensive",
  can_refresh = function (self, event, target, player, data)
    return target == player and player:hasSkill(jushou.name) and table.contains(data.use.tos, player.next)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    player.room:setPlayerMark(player,"@pang__jushou", 0)
    player.room:setPlayerMark(player,"@pang__jushou_restrict-round", 1)
  end,
})


return jushou