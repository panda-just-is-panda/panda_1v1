local tongqu = fk.CreateSkill {
  name = "pang__tongqu",
}

Fk:loadTranslationTable{
  ["pang__tongqu"] = "通渠",
  [":pang__tongqu"] = "摸牌阶段结束时，你将手牌摸至三张，然后你可以弃置一张牌并将此技能下次发动时机改为出牌阶段结束时或准备阶段。",
  ["#pang__tongqu"] = "通渠：你可以将所有非本回合获得的手牌作为【无中生有】使用。",

  ["@@pang__tongqu-inhand-turn"] = "本回合获得",

  ["$pang__tongqu1"] = "兴凿修渠，依水屯军！",
  ["$pang__tongqu2"] = "开渠疏道，以备军实！",
}




return tongqu