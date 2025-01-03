local Player = game:GetService("Players")
local localplayer = Player.LocalPlayer


local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Gym Star Simulator",
   Icon = "codesandbox", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Gym Star Simulator",
   LoadingSubtitle = "By _pastlive",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PastliveHub", -- Create a custom folder for your hub/game
      FileName = "Pastlive"
   },
})

local Tab = Window:CreateTab("Main", "infinity")
local Section = Tab:CreateSection("Main")

local requiredStamina = 20
local maxStamina = localplayer:WaitForChild("MaxStamina")

local Toggle = Tab:CreateToggle({
    Name = "AutoWeight",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.AutoRoll = Value
        if _G.AutoRoll then
            spawn(function()
                while _G.AutoRoll do
                    wait()
                    pcall(function()
                        local stamina = localplayer:WaitForChild("CurStamina")
                        local click = game:GetService("ReplicatedStorage"):WaitForChild("Msg"):WaitForChild("Click")
                        local cooldownTime = 5 -- Cooldown time in seconds

                        -- Function to wait for stamina regeneration
                        local function waitForStamina(targetValue)
                            while stamina.Value < targetValue do
                                stamina.Changed:Wait() -- Wait for stamina to change
                            end
                        end

                        -- Main logic
                        if stamina.Value >= requiredStamina then
                            click:FireServer()
                        else
                            print("Waiting for stamina to regenerate...")
                            waitForStamina(requiredStamina)
                            print("Cooldown: Waiting for", cooldownTime, "seconds")
                            task.wait(cooldownTime) -- Wait for the cooldown before continuing
                        end
                    end)
                end
            end)
        end
    end,
})

local Slider = Tab:CreateSlider({
    Name = "Set Stamina",
    Range = {10, maxStamina.Value},
    Increment = 1,
    Suffix = " Stamina",
    CurrentValue = requiredStamina,
    Flag = "Slider_RequiredStamina",
    Callback = function(Value)
        requiredStamina = Value -- Update the required stamina value dynamically
        print("Required stamina set to:", requiredStamina)
    end,
})

local Divider = Tab:CreateDivider()

local Button = Tab:CreateButton({
   Name = "WIP",
   Callback = function()

   end,
})

local Tab = Window:CreateTab("Info", "blend")

local Paragraph = Tab:CreateParagraph({Title = "Made by _pastlive", Content = "do not copy pls"})
