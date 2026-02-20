local qianchong = fk.CreateSkill {
  name = "pang__qianchong",
  tags = {Skill.Switch},
}

qianchong:addEffect(fk.CardUsing, {
    mute = true,
  can_trigger = function(self, event, target, player, data)
    return data.card and player:hasSkill(qianchong.name) and data.card.color == Card.Black and
    (data.card.trueName == "slash" and player:getSwitchSkillState(qianchong.name, true) ~= fk.SwitchYang
    or data.card.type == Card.TypeTrick and player:getSwitchSkillState(qianchong.name, true) == fk.SwitchYang)
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
    prompt = "#pang__qianchong",
    skill_name = qianchong.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if player:getSwitchSkillState(qianchong.name, true) ~= fk.SwitchYang then
        player:broadcastSkillInvoke(qianchong.name, 2)
    else
        player:broadcastSkillInvoke(qianchong.name, 1)
    end
    data:removeAllTargets()
    data.toCard = nil
  end,
})

Fk:loadTranslationTable {["pang__qianchong"] = "谦冲",
[":pang__qianchong"] = "转换技，当一名角色使用①黑色【杀】②黑色锦囊牌时，你可以令此牌无效。",

[":pang__qianchong_yang"] = "转换技，当一名角色使用<font color=\"#E0DB2F\">①黑色【杀】</font>" ..
"②黑色锦囊牌时，你可以取消之。",
[":pang__qianchong_yin"] = "转换技，当一名角色使用①黑色【杀】"..
"<font color=\"#E0DB2F\">②黑色锦囊牌</font>时，你可以取消之。",

["#pang__qianchong"] = "谦冲：你可以令此牌无效",


["$pang__qianchong1"] = "谦谨行事，方能多吉少恙。",
  ["$pang__qianchong2"] = "宫闱之内，何必擅摄外事。",
}

return qianchong