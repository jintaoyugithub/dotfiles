local dependencies = {
    git = "git",
    nodejs = "node",
    fzf = "fzf",
    fd = "fd",
    ripgrep = "rg",
}


-- check and install the dependencies of neovim/system --
function packageFound(cmd)
    local command = string.format("%s --version", cmd)

    if os.execute(command) == 0 then
        return true
    else
        return false
    end
end


function checkDependencies() 
    for name, cmd in pairs(dependencies) do 
        if not packageFound(cmd) then
            print(name .. " NOT FOUND")
        end
    end
end

local function main()
    checkDependencies()
end


main()



