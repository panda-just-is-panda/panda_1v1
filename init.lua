
local prefix = "packages.panda_one_vs_one.pkg."
local panda1 = require "packages.panda_one_vs_one.pkg.panda_one_vs_one1"
local panda2 = require "packages.panda_one_vs_one.pkg.panda_one_vs_one2"

Fk:loadTranslationTable{
  ["panda_one_vs_one"] = "胖胖11",
}

return{
   panda1,
   panda2,
}


