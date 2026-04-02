local extension = Package:new("panda_one_vs_one3")
extension.extensionName = "panda_one_vs_one"
extension:loadSkillSkelsByPath("./packages/panda_one_vs_one/pkg/panda_one_vs_one3/skills")
extension.game_modes_whitelist = {
  "klee_1v1",
}

Fk:loadTranslationTable{
  ["panda_one_vs_one3"] = "新胖预告",
  ["pang"] = "胖",
}



return extension