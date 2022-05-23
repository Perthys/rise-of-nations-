local Sort = loadstring(game:HttpGet("https://raw.githubusercontent.com/Perthys/SmartSort/main/main.lua"))()

local Cities = Workspace.Baseplate.Cities
local PopulationAlgorithim = Sort.new():Add("Population", 1, "Higher");
local LengthAlgorithim = Sort.new():Add("Length", 1, "Higher");

local function ConvertToDecimal(Number)
    local NewNum = tostring(Number)
    local Divider = #NewNum % 3
    local NewString = NewNum:sub(1, Divider)

    for ConcatString in string.gmatch(NewNum:sub(Divider + 1, #NewNum), "%d%d%d") do
        NewString = NewString .. "," .. ConcatString
    end
    
    return (NewString:sub(1, 1) == ",") and NewString:sub(2) or NewString
end

local function GetBiggestCityInWorld(GetStringOnly)
    local CitiesTable = {}
    for Index, Country in pairs(Cities:GetChildren()) do
        for Index, Value in pairs(Country:GetChildren()) do
            if Value:IsA("Part") then     
                table.insert(CitiesTable, {
                    Population = Value.Population.Value.X;
                    Instance = Value;
                 })
            end
        end
    end
    
    local Sorted = PopulationAlgorithim:Sort(CitiesTable)
    local Biggest = Sorted[#Sorted]
    local CityString = ("\n%sPopulation: %s City: %s \n"):format((" "):rep(3), ConvertToDecimal(Biggest.Population), Biggest.Instance.Name)
    
    CityString = ("\n%s: (%s)"):format(Biggest.Instance.Parent.Name, ConvertToDecimal(Biggest.Population))..CityString;
    
    if GetStringOnly then
        return CityString
    else
        return Biggest.Instance, CityString
    end
end

local function GetTopCitiesInCountry(Country, Top)
    local CitiesTable = {}
    local ReturnedCities = {}
    local Country = Cities:FindFirstChild(Country)

    if Country then    
        for Index, City in pairs(Country:GetChildren()) do
            if City:IsA("Part") then    
                local Population = City:FindFirstChild("Population");
                
                if Population then
                    table.insert(CitiesTable, {
                        Population = Population.Value.X;
                        Instance = City;
                    })
                end
            end
        end
        
        local Sorted = PopulationAlgorithim:Sort(CitiesTable)
        
        for i = #Sorted, #Sorted - Top, -1 do
            if Sorted[i] then
                local City = Sorted[i]
          
                table.insert(ReturnedCities, City)
            end
        end
        
        return ReturnedCities
    end
    
    return false
end

local function MakeString(Data, Indent)
    Indent = Indent or 2
    
    local PreConcatStrings = {}
    local ReturnedString = ("\n%s: "):format(Data[1].Instance.Parent.Name)
    local BeforeConcat = ""
    local TotalCombinedPopulation = 0;
    
    local StringFormat = ("\n %s"):format((" "):rep(Indent))..("Population: %s City: %s")
    
    for Index, Value in pairs(Data) do
        local City = Value.Instance;
        local Population = Value.Population;
        
        TotalCombinedPopulation = TotalCombinedPopulation + Population;
        local StringToUse = StringFormat:format(ConvertToDecimal(Population), City.Name)
        BeforeConcat = BeforeConcat..StringToUse;
    end
    
    ReturnedString = ReturnedString .. ("(%s)"):format(ConvertToDecimal(TotalCombinedPopulation))
    
    ReturnedString = ReturnedString..BeforeConcat
    
    return ReturnedString
end

local TopCities = GetTopCitiesInCountry("United States", 4)
print(MakeString(TopCities))

print(GetBiggestCityInWorld(true))


--print(GetBiggestCityInWorld())
