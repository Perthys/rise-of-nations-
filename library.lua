local game = game;
local workspace = workspace;

local GetService = game.GetService;

local task = task;
local spawn = task.spawn
local wait = task.wait

local Players = GetService(game, "Players");

local LocalPlayer = Players.LocalPlayer

local Leaderstats = LocalPlayer.leaderstats
local PlayerGui = LocalPlayer.PlayerGui;

local Countries = workspace.CountryData;
local CreateCountry = workspace.GameManager.CreateCountry
local AbandonRemote = workspace.GameManager.Abandon;
local ManageAlliance = workspace.GameManager.ManageAlliance

local Library = {}

function Library.Abandon()
    AbandonRemote:FireServer()
end


function Library.JoinCountry(Country)
    Abandon()
    wait()
    CreateCountry:FireServer(Country.Name)
end


function Library.SendFreeShit(Country, MoneyAmount, ManpowerAmount)
    local AmountMoney = MoneyAmount or Countries[Leaderstats.Country.Value].Economy.Balance.Value
    local AmountManpower = ManpowerAmount or Countries[Leaderstats.Country.Value].Manpower.Value.X - Countries[Leaderstats.Country.Value].Manpower.Value.Y * 2
    
    ManageAlliance:FireServer(Country.Name, "Aid", {
        {
            AmountMoney, "One Time";
        };
        {
            AmountManpower, "One Time"
        };
    })
    
end


function Library.GetAnyCountry()
    for Index, Country in pairs(Countries:GetChildren()) do
        if Country:IsA("Folder") then
            print(Country.Name)
            local Leader = Country:FindFirstChild("Leader");
            local ConcatedString = Country.Name.."AI"
        
            print(ConcatedString)
        
            if Leader.Value == ConcatedString then
                return Country;
            end
        end
    end

    return false
end



function Library.SellResource(Country, ResourceName, Amount)
    ManageAlliance:FireServer(Country.Name, "ResourceTrade", {
        ResourceName;
        "Sell";
        Amount;
        Amount;
        "Trade"
    })
end


function Library.ClearNotifs()
    for Index, Notifcation in pairs(PlayerGui.GameGui.MainFrame:GetChildren()) do
        if Notifcation.Name == "AlertSample" then
            Notifcation:Destroy()
        end
    end
end


function Library.SellAllResources()
    local CurrentCountry = Countries[Leaderstats.Country.Value]
    local Resources = CurrentCountry.Resources;
    
    for Index, Resource in pairs(Resources:GetChildren()) do
        if Resource.Value > 0 and Resource.Flow.Value > 0 then
            local CountriesTable = Countries:GetChildren()
            
            for Index, Country in pairs(CountriesTable) do
                SellResource(Country, Resource.Name, Resource.Flow.Value)
                ClearNotifs()
                wait()
            end
        end
    end
    
end

return Library



