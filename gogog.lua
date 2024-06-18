local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Mobile%20Friendly%20Orion')))()
local Player = game.Players.LocalPlayer
local SoundService = game:GetService("SoundService")

-- Function to play sound
local function PlayIntroSound()
    local introSound = Instance.new("Sound", SoundService)
    introSound.SoundId = "rbxassetid://1846396460"
    introSound.Volume = 1
    introSound:Play()
end

-- Play intro sound immediately
PlayIntroSound()

-- Create the window after playing the intro sound
local Window = OrionLib:MakeWindow({
    Name = "HumaHubKeySystem",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest",
    IntroText = "Carregando Aguarde..."
})

-- Function to load the main script if the key is correct
function MakeScriptHub()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tekulua/HumaHubV1/main/HumaHubV1.txt"))()  
end

-- Notification for logged in user
OrionLib:MakeNotification({
    Name = "Para Logar!",
    Content = "Você precisa de uma Key, " .. Player.Name .. ".",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Define the list of valid keys and corresponding player names
local validUsers = {
    {name = "mayarameama", key = "admin"},
    {name = "RAFACHEL13", key = "admin"},
    {name = "Kokoshibo_ofz", key = "zaquelgu"}, --Vence dia 18/07/24
    {name = "Player4", key = "Teste4"},
    {name = "Player5", key = "Teste5"},
    {name = "Player6", key = "Teste6"}
}
getgenv().KeyInput = "string"

-- Create a tab for key input
local Tab = Window:MakeTab({
    Name = "Loggin",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Textbox for entering the key
Tab:AddTextbox({
    Name = "Loggin",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        getgenv().KeyInput = Value
    end
})

-- Function to check if the entered key and player name are valid
local function IsValidUser(playerName, inputKey)
    for _, user in ipairs(validUsers) do
        if user.name == playerName and user.key == inputKey then
            return true
        end
    end
    return false
end

-- Function to check if the player is an admin
local function IsAdmin(playerName)
    return playerName == "mayarameama" or playerName == "RAFACHEL13"
end

-- Function to play sound on button click
local function PlayClickSound(soundId)
    local clickSound = Instance.new("Sound", SoundService)
    clickSound.SoundId = soundId
    clickSound.Volume = 1
    clickSound:Play()
end

-- Button to check the entered key
Tab:AddButton({
    Name = "Checar Login",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Chegando Login",
            Content = "Checando o login no banco de dados, aguarde...",
            Image = "rbxassetid://4483345998",
            Time = 5
        })

        -- Play different sounds based on login result
        if IsValidUser(Player.Name, getgenv().KeyInput) then
            -- Correct login sound
            PlayClickSound("rbxassetid://3997124966")
            wait(1)  -- Aguarda por 1 segundo antes de exibir a notificação de login correto
            OrionLib:MakeNotification({
                Name = "Loggin Correto!",
                Content = "O login inserido está correto!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            wait(1)  -- Aguarda mais 1 segundo antes de continuar
            OrionLib:Destroy()
            wait(0.3)  -- Aguarda 0.3 segundos antes de continuar
            MakeScriptHub()
        else
            -- Incorrect login sound (using provided sound ID)
            PlayClickSound("rbxassetid://2865228021")
            wait(1)  -- Aguarda por 1 segundo antes de exibir a notificação de login incorreto
            OrionLib:MakeNotification({
                Name = "Loggin Incorreto!",
                Content = "O login inserido está incorreto.",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

-- Button to copy the Discord link for the key
Tab:AddButton({
    Name = "Cadastrar/Copiar Discord",
    Callback = function()
        PlayClickSound("rbxassetid://876939830") -- Play the click sound when the button is pressed
        setclipboard("https://discord.gg/N7f8WRQc2G")
    end
})

-- Create the admin tab if the player is an admin
if IsAdmin(Player.Name) then
    local AdminTab = Window:MakeTab({
        Name = "Admin",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    
    AdminTab:AddLabel("Admin Commands Here")
    -- Add more admin functionalities as needed
end

OrionLib:Init()
