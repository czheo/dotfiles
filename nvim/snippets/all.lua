local commentKeyWords = f(function(_, snip)
  local date = os.date("%m/%d/%Y")
  return snip.captures[1] .. " (czheo) " .. date .. ": "
end)

return {
  s({ trig = "(TODO|FIXME|NOTE|HACK)@", regTrig = true, trigEngine = "ecma" }, commentKeyWords),
}
