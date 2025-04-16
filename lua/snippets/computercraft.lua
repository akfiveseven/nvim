-- Load the LuaSnip module
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node


-- LUA SNIPPETS

ls.add_snippets("lua", {
  s("args", {
    t("local args = {...}")
  }),
  s("forward", {
    t("turtle.forward()"),
  }),
  s("forward", {
    t("turtle.back()"),
  }),
  s("up", {
    t("turtle.up()"),
  }),
  s("down", {
    t("turtle.down()"),
  }),
  s("refuel", {
    t("turtle.refuel()"),
  }),
  s("right", {
    t("turtle.turnRight()"),
  }),
  s("left", {
    t("turtle.turnLeft()"),
  }),
  s("craft", {
    t("turtle.craft()"),
  }),
  s("craft", {
    t("turtle.craft(number quantity)"),
  }),
  s("detect", {
    t("turtle.detect()"),
  }),
  s("detectUp", {
    t("turtle.detectUp()"),
  }),
  s("detectDown", {
    t("turtle.detectDown()"),
  }),
  s("attack", {
    t("turtle.attack()"),
  }),
  s("attackUp", {
    t("turtle.attackUp()"),
  }),
  s("attackDown", {
    t("turtle.attackDown()"),
  }),
  s("inspect", {
    t("turtle.inspect()"),
  }),
  s("inspectUp", {
    t("turtle.inspectUp()"),
  }),
  s("inspectDown", {
    t("turtle.inspectDown()"),
  }),
  s("dig", {
    t("turtle.dig()"),
  }),
  s("digUp", {
    t("turtle.digUp()"),
  }),
  s("digDown", {
    t("turtle.digDown()"),
  }),
  s("place", {
    t("turtle.place()"),
  }),
  s("placeUp", {
    t("turtle.placeUp()"),
  }),
  s("placeDown", {
    t("turtle.placeDown()"),
  }),
  s("compare", {
    t("turtle.compare()"),
  }),
  s("compareUp", {
    t("turtle.compareUp()"),
  }),
  s("compareDown", {
    t("turtle.compareDown()"),
  }),
  s("compareTo", {
    t("turtle.compareTo(number slot)"),
  }),
  s("drop", {
    t("turtle.drop()"),
  }),
  s("dropUp", {
    t("turtle.dropUp()"),
  }),
  s("dropDown", {
    t("turtle.dropDown()"),
  }),
  s("suck", {
    t("turtle.suck()"),
  }),
  s("suckUp", {
    t("turtle.suckUp()"),
  }),
  s("suckDown", {
    t("turtle.suckDown()"),
  }),
  s("fuel", {
    t("turtle.getFuelLevel()"),
  }),
  s("fuel", {
    t("turtle.getFuelLimit()"),
  }),
  s("transferTo", {
    t("turtle.transferTo("),
    i(1),
    t(")")
  }),
  s("transferTo", {
    t("turtle.transferTo(number slot [, number quantity])"),
  }),
  s("getSelectedSlot", {
    t("turtle.getSelectedSlot()"),
  }),
  s("getItemCount", {
    t("turtle.getItemCount("),
    i(1),
    t(")")
  }),
  s("getItemCount", {
    t("turtle.getItemCount("),
    i(1),
    t("[number slotNum])")
  }),
  s("getItemSpace", {
    t("turtle.getItemSpace("),
    i(1),
    t(")")
  }),
  s("getItemSpace", {
    t("turtle.getItemSpace("),
    i(1),
    t("[number slotNum])")
  }),
  s("getItemDetail", {
    t("turtle.getItemDetail("),
    i(1),
    t(")")
  }),
  s("getItemDetail", {
    t("turtle.getItemDetail("),
    i(1),
    t("[number slotNum])")
  }),
  s("equipLeft", {
    t("turtle.equipLeft()")
  }),
  s("equipRight", {
    t("turtle.equipRight()")
  }),
})


-- Print a message to confirm snippets are loaded
print("Custom computercraft snippets loaded successfully!")
