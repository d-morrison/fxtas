local appendix = false
local appendix_counter = 18
local chapters = {}
local current_appendix_label = ""

-- First pass: Collect chapter IDs
function collectChapters(el)
if el.level == 1 then
if el.classes:includes("appendix") then
appendix_counter = appendix_counter + 1
current_appendix_label = string.char(64 + appendix_counter)
chapters[el.identifier] = current_appendix_label
appendix = true
else
  appendix = false
end
elseif appendix then
-- Adjust numbering for subchapters based on original numbering
local original_number = pandoc.utils.stringify(el.content):match("^%d+[%.%d]*")
if original_number then
local subchapter_label = current_appendix_label .. original_number:gsub("^%d+", "")
chapters[el.identifier] = subchapter_label
local new_text = subchapter_label .. " " .. pandoc.utils.stringify(el.content):gsub("^%d+[%.%d]*%s*", "")
el.content = {pandoc.Str(new_text)}
end
end
return el
end

-- Second pass: Adjust chapter numbers and links
function processHeaders(el)
if el.level == 1 then
if el.classes:includes("appendix") then
local text = pandoc.utils.stringify(el.content)
local new_text = chapters[el.identifier] .. " " .. text:gsub("^%d+[%.%d]*%s*", "")
el.content = {pandoc.Str(new_text)}
appendix = true
else
  appendix = false
end
end
return el
end

function processLinks(el)
local target = el.target:match("#(.*)")
if target and chapters[target] then
el.content = {pandoc.Str("Section " .. chapters[target])}
end
return el
end

-- Define Pandoc passes
return {
  { Header = collectChapters },
  { Header = processHeaders, Link = processLinks }
}
