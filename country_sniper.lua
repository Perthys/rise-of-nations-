function Snipe (Settings)
    if game.PlaceId == 3095043503 then
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        
        local Country = Settings["Country"]
        
        local Players = game:GetService("Players");
        
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer.PlayerGui;
        
        local GameGui = PlayerGui:WaitForChild("GameGui")
        local FirstFrame = GameGui:WaitForChild("FirstFrame");
        local CountryList = FirstFrame:WaitForChild("CountryList");
        
        local GameManager = workspace:WaitForChild("GameManager");
        local CreateCountry = GameManager:WaitForChild("CreateCountry")
        
        repeat wait() until #CountryList:GetChildren() > 2
        firesignal(CountryList[Country].MouseButton1Click)
        firesignal(FirstFrame.Play.MouseButton1Click)
        
        print("Attempting To Snipe ".. Country)
        CreateCountry:FireServer(Country)
    end
end

return Snipe
