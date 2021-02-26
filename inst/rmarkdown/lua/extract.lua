function format_non_code(div)

  for i,el in pairs(div.content) do
    -- Divs need to do a dive because they contain blocks    
    if (el.t == "Div") then
      format_non_code(el)
    end
    -- Anything but code blocks, prepend comments
    if (el.t ~= "CodeBlock" and el.content ~= nil) then
      -- iterate through each line of the block
      for j,ln in pairs(el.content) do
        table.insert(ln, 1, {pandoc.Str "# "})
      end
    end
  end

  return div
end

function Pandoc(doc)
    local hblocks = {}
    for i,el in pairs(doc.blocks) do
        if (el.t == "Div" and el.classes[1] == "challenge") or
           (el.t == "Header") then
           --format_non_code(el)
           table.insert(hblocks, el)
        end
    end
    return pandoc.Pandoc(hblocks, doc.meta)
end
