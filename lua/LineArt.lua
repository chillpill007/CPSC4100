function getFontTable()
    oldInput = io.input()
    io.input("font.txt")
    -- First six characters
    height = io.read("*number")
    io.read()
    local map = {}
    local letter = io.read(1)
    io.read()
    while letter ~= nil do
        map[letter] = ""
        -- Read large letter and put in map
        for word = 1, height do
            newPart = io.read()
            map[letter] = map[letter] .. newPart .. "\n"
        end
        -- Get letter
        letter = io.read(1)
        io.read()
    end
    io.input(oldInput)
    return map
end

function printAsciiString(string, fontMap)
    local characterTable = {}
    for word in string:gmatch(".") do
        characterTable[#characterTable+1] = fontMap[word]
    end
    printTableLines(characterTable)
end

function printTableLines(characterTable)
    -- Base case
    ContainsLines = false
    for i, letter in ipairs(characterTable) do
        if(string.find(characterTable[1], "\n") ~= nil) then
            ContainsLines = true
        end
    end
    if ContainsLines == false then
        return
    end
    -- Recursive Case
    local thisLine = ""
    local newCharacterTable = {}
    for i, letter in ipairs(characterTable) do
        -- Find cutpoint between lines
        local wordCutoff = string.find(letter, "\n")
        -- If cutpoint was found
        if wordCutoff ~= nil then
            -- Save next line to print and modify table to not remove next line
            thisLine = thisLine .. string.sub(letter, 0, wordCutoff-1)
            newCharacterTable["size" .. i] = wordCutoff
            newCharacterTable[i] = string.sub(letter, wordCutoff+1, string.len(letter))
        else
            -- Otherwise print just strings
            thisLine = thisLine .. string.rep(" ", characterTable["size" .. i])
        end
    end
    -- Print next line
    print(thisLine)
    printTableLines(newCharacterTable)
end

function lineArtREPL(fontMap)
    while true do
        print("Type in a word to turn into line-art. To exit print-loop press ENTER")
        printWord = io.read()
        if(printWord == "") then
            break
        end
        printAsciiString(printWord, fontMap)
    end
end

function lineArtMaker(fontMap)
    while boundLetter == nil or boundLetter == "" do
        print("Type in a letter to be bound to ART")
        boundLetter = io.read(1)
    end
    -- Flush out rest of io so that the rest of that line isn't included
    io.read()

    print("Binding " .. boundLetter .. " to given art. Create your art here!")
    newArt = ""
    local newArtMap = {}
    local symbolSize = 0
    for i=1,8 do
        newArtMap[i] = io.read()
        if(string.len(newArtMap[i]) > symbolSize) then
            symbolSize = string.len(newArtMap[i])
        end
    end
    for i, word in pairs(newArtMap) do
        print(word .. " : " .. symbolSize - string.len(word))
        newArt = newArt .. word .. string.rep(" ", symbolSize - string.len(word)) .. "\n"
    end
    fontMap[boundLetter] = newArt
end

function saveLineArt(fontMap)
    print("Saving...")
    io.output("font.txt")
    io.write(height .. "\n")
    for i, word in pairs(fontMap) do
        io.write(i .. "\n" .. word)
    end
    print("Done!")
    io.output():close()
end

local fontMap = getFontTable()

print("Welcome to the CPSC4100 Line Art program!")
while true do
    print("Type 1 to enter the line-art loop!")
    print("Type 2 to enter the line-art editor!")
    print("Type 3 to save your current keybind setup and override the existing text file!")
    print("Press enter without input to exit!")
    choice = io.read()
    if(choice == "1") then
        lineArtREPL(fontMap)
        print()
        print("Welcome to the CPSC4100 Line Art program!")
    elseif(choice == "2") then
        lineArtMaker(fontMap)
        print("Your art has been added to the current lineart map! Press 3 in the main menu to save your new keybind!")
        print()
        print("Welcome to the CPSC4100 Line Art program!")
    elseif(choice == "3") then
        saveLineArt(fontMap)
        print()
    elseif(choice == "") then
        break
    end
end
