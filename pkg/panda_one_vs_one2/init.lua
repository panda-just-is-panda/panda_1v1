local extension = Package:new("panda_one_vs_one2")
extension.extensionName = "panda_one_vs_one"
extension:loadSkillSkelsByPath("./packages/panda_one_vs_one/pkg/panda_one_vs_one2/skills")
extension.game_modes_whitelist = {
  "klee_1v1",
}

Fk:loadTranslationTable{
  ["panda_one_vs_one2"] = "胖胖扩",
  ["pang"] = "胖",
}

local mizhu = General:new(extension, "pang__mizhu", "shu", 3, 3, General.Male)
mizhu:addSkill("pang__chouzi&")
mizhu:addSkill("pang__jugu")
Fk:loadTranslationTable{
  ["pang__mizhu"] = "糜竺",
  ["#pang__mizhu"] = "挥金追义",
  ["designer:pang__mizhu"] = "胖即是胖",
  ["illustrator:pang__mizhu"] = "官方",

  ["~pang__mizhu"] = "劣弟背主，我之罪也。",
}

local xusheng = General:new(extension, "pang__xusheng", "wu", 4, 4, General.Male)
xusheng:addSkill("pang__yicheng")
Fk:loadTranslationTable{
  ["pang__xusheng"] = "徐盛",
  ["#pang__xusheng"] = "江东铁壁",
  ["designer:pang__xusheng"] = "胖即是胖",
  ["illustrator:pang__xusheng"] = "官方",

  ["~pang__xusheng"] = "可怜一身胆略，皆随一抔黄土。",
}

return extension