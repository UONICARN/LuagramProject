package = "luagram-client"
version = "1.2"
source = {
   url = "git://github.com/LuagramTeam/LuagramProject.git",
   tag = "v1.2",
   branch = "master"
}
description = {
   summary = "telegram cli client",
   homepage = "https://github.com/LuagramTeam/LuagramProject.git",

   license = "MIT"
}
dependencies = {
  "lua >= 5.3"
}
build = {
   type = "builtin",
   modules = {
     ["luagram-client"] = "luagram-client.lua"
   }
}
