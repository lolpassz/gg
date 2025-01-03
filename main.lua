local a=game:GetService"Players"
local b=a.LocalPlayer


local c=loadstring(game:HttpGet'https://sirius.menu/rayfield')()
local d=c:CreateWindow{
Name="Gym Star Simulator",
Icon="codesandbox",
LoadingTitle="Gym Star Simulator",
LoadingSubtitle="By _pastlive",
Theme="Default",

DisableRayfieldPrompts=false,
DisableBuildWarnings=false,

ConfigurationSaving={
Enabled=true,
FolderName="PastliveHub",
FileName="Pastlive"
},
}

local e=d:CreateTab("Main","infinity")
e:CreateSection"Main"

local f=20
local g=b:WaitForChild"MaxStamina"

e:CreateToggle{
Name="AutoWeight",
CurrentValue=false,
Flag="Toggle1",
Callback=function(h)
_G.AutoRoll=h
if _G.AutoRoll then
spawn(function()
while _G.AutoRoll do
wait()
pcall(function()
local i=b:WaitForChild"CurStamina"
local j=game:GetService"ReplicatedStorage":WaitForChild"Msg":WaitForChild"Click"
local k=5


local function waitForStamina(l)
while i.Value<l do
i.Changed:Wait()
end
end


if i.Value>=f then
j:FireServer()
else
print"Waiting for stamina to regenerate..."
waitForStamina(f)
print("Cooldown: Waiting for",k,"seconds")
task.wait(k)
end
end)
end
end)
end
end,
}

e:CreateSlider{
Name="Set Stamina",
Range={10,g.Value},
Increment=1,
Suffix=" Stamina",
CurrentValue=f,
Flag="Slider_RequiredStamina",
Callback=function(h)
f=h
print("Required stamina set to:",f)
end,
}

e:CreateDivider()

e:CreateButton{
Name="WIP",
Callback=function()

end,
}

local h=d:CreateTab("Info","blend")

h:CreateParagraph{Title="Made by _pastlive",Content="do not copy pls"}
