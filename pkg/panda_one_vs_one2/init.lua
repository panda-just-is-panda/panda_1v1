local extension = Package:new("panda_one_vs_one2")
extension.extensionName = "panda_one_vs_one"
extension:loadSkillSkelsByPath("./packages/panda_one_vs_one/pkg/panda_one_vs_one2/skills")
extension.game_modes_whitelist = {
  "klee_1v1",
}

Fk:loadTranslationTable{
  ["panda_one_vs_one2"] = "新胖预告",
  ["pang"] = "胖",
}


local zhouqun = General:new(extension, "pang__zhouqun", "shu", 3, 3, General.Male)
zhouqun:addSkill("pang__tiansuan")
zhouqun:addSkill("pang__chenshuo")
Fk:loadTranslationTable{
  ["pang__zhouqun"] = "周群",
  ["#pang__zhouqun"] = "占天明徵",
  ["designer:pang__zhouqun"] = "胖即是胖",
  ["illustrator:pang__zhouqun"] = "官方",

  ["~pang__zhouqun"] = "知万物而不知己命，大谬也。",
}

local sunhuan = General:new(extension, "pang__sunhuan", "wu", 4, 4, General.Male)
sunhuan:addSkill("pang__eyao")
Fk:loadTranslationTable{
  ["pang__sunhuan"] = "孙桓",
  ["#pang__sunhuan"] = "扼龙决险",
  ["designer:pang__sunhuan"] = "胖即是胖",
  ["illustrator:pang__sunhuan"] = "官方",

  ["~pang__sunhuan"] = "此建功立业之时，奈何。",
}

local jiangji = General:new(extension, "pang__jiangji", "wei", 3, 3, General.Male)
jiangji:addSkill("pang__jichou")
jiangji:addSkill("pang__jilun")
Fk:loadTranslationTable{
  ["pang__jiangji"] = "蒋济",
  ["#pang__jiangji"] = "盛魏昌杰",
  ["designer:pang__jiangji"] = "胖即是胖",
  ["illustrator:pang__jiangji"] = "官方",

  ["~pang__jiangji"] = "洛水之誓，言犹在耳……咳咳咳……",
}

local zhangmancheng = General:new(extension, "pang__zhangmancheng", "qun", 4, 4, General.Male)
zhangmancheng:addSkill("pang__zhongji")
zhangmancheng:addSkill("pang__lvecheng")
Fk:loadTranslationTable{
  ["pang__zhangmancheng"] = "张曼成",
  ["#pang__zhangmancheng"] = "蚁萃宛洛",
  ["designer:pang__zhangmancheng"] = "胖即是胖",
  ["illustrator:pang__zhangmancheng"] = "官方",

  ["~pang__zhangmancheng"] = "逡巡不前，坐以待毙。",
}


return extension