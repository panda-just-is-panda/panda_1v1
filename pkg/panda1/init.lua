local extension = Package:new("panda1")
extension.extensionName = "panda"

extension:loadSkillSkelsByPath("./packages/panda/pkg/panda1/skills")

Fk:loadTranslationTable{
  ["panda1"] = "胖胖扩",
  ["pang"] = "胖",
}

local gaoshun = General:new(extension, "pang__gaoshun", "qun", 4, 4, General.Male)
gaoshun:addSkill("pang__xianzhen")
Fk:loadTranslationTable{
  ["pang__gaoshun"] = "高顺",
  ["#pang__gaoshun"] = "攻无不克",
  ["designer:pang__gaoshun"] = "胖即是胖",
  ["illustrator:pang__gaoshun"] = "鄧Sir",

  ["~gaoshun"] = "生死有命……",
}

return extension