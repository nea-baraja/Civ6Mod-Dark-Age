--[[
local RAMSES_II_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_RAMSES_II"].Index;


function RamsesIIFaithBuyWonder(unitOwner, unitID,greatPersonClassID, greatPersonIndividualID)
   if greatPersonIndividualID ~= RAMSES_II_INDEX then
      return;
   end
   
   local owner = Players[unitOwner];

   local unit = UnitManager.GetUnit(unitOwner, unitID);
   local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
   --local districtAtPlot = CityManager.GetDistrictAt(unitPlot);
   local city = Cities.GetPlotPurchaseCity(unitPlot);
   print(city)
   local current = city:GetBuildQueue():CurrentlyBuilding();
   if not current then
      return;
   end
   local buildingInfo = GameInfo.Buildings[current];
   if not buildingInfo.IsWonder then
      return;
   end
   local cost = buildingInfo.Cost;
   local iProductionProgress = city:GetBuildQueue():GetBuildingProgress( buildingInfo.Index );
   local productionNeeded = cost - iProductionProgress;
   local faithBalance = owner:GetReligion():GetFaithBalance();
   if(faithBalance > productionNeeded) then
      owner:GetReligion():ChangeFaithBalance(-productionNeeded);
      city:GetBuildQueue():FinishProgress();
   else
      owner:GetReligion():ChangeFaithBalance(-faithBalance);
      city:GetBuildQueue():AddProgress(faithBalance);
   end
   print('LA II ACTIVATED')
end

Events.UnitGreatPersonActivated.Add( RamsesIIFaithBuyWonder );


function OnImprovementAddedToMap(locationX, locationY, improvementType, eImprovementOwner, resource, isPillaged, isWorked)
   local plot = Map.GetPlot(locationX,locationY);
   local owner = Players[plot:GetOwner()];
      print(improvementType)

   local pType = GameInfo.Improvements[improvementType].ImprovementType;

   if pType == 'IMPROVEMENT_FARM' then
      plot:SetOwner(owner:GetID())
      local pCity = owner:GetCities():GetCapitalCity();
       pCity:GetBuildQueue():CreateDistrict(26,plot);
    end
end
Events.ImprovementAddedToMap.Add(OnImprovementAddedToMap);






include("InstanceManager");
include("SupportFunctions");
include("TradeSupport");

pUnit = UI.GetHeadSelectedUnit()
local operationParams = {};
operationParams[UnitOperationTypes.PARAM_X0] = 8
operationParams[UnitOperationTypes.PARAM_Y0] = 12
operationParams[UnitOperationTypes.PARAM_X1] = pUnit:GetX()
operationParams[UnitOperationTypes.PARAM_Y1] = pUnit:GetY()



print(pUnit:GetID())
   
      --if (UnitManager.CanStartOperation(pUnit, UnitOperationTypes.MAKE_TRADE_ROUTE, nil, operationParams)) then
         UnitManager.RequestOperation(pUnit, UnitOperationTypes.MAKE_TRADE_ROUTE, operationParams)
    --  end

]]
