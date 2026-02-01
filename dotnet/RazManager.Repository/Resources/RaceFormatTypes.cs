using Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType;
using System.Collections.Generic;
using System.Resources;


namespace RazManager.Repository.Resources
{
    public static partial class Constants
    {
        public static IEnumerable<RaceFormatTypeSelect> RaceFormatTypes
        {
            get
            {
                return new List<RaceFormatTypeSelect>()
                {
                    new RaceFormatTypeSelect
                    {
                        Id = RaceFormatTypeId.AllDriversAllLanesNext,
                        Name = new ResourceManager(typeof(RazManager.Repository.Resources.RaceFormatType)).GetString(RaceFormatTypeId.AllDriversAllLanesNext.ToString()),
                        IndicatorEventUserCombined = false
                    },
                    new RaceFormatTypeSelect
                    {
                        Id = RaceFormatTypeId.AllDriversAllLanesSpread,
                        Name = new ResourceManager(typeof(RazManager.Repository.Resources.RaceFormatType)).GetString(RaceFormatTypeId.AllDriversAllLanesSpread.ToString()),
                        IndicatorEventUserCombined = false
                    },
                    new RaceFormatTypeSelect
                    {
                        Id = RaceFormatTypeId.AllDriversAllLanesAllDrivers,
                        Name = new ResourceManager(typeof(RazManager.Repository.Resources.RaceFormatType)).GetString(RaceFormatTypeId.AllDriversAllLanesAllDrivers.ToString()),
                        IndicatorEventUserCombined = false
                    },
                    new RaceFormatTypeSelect
                    {
                        Id = RaceFormatTypeId.AllDriversUniqueController,
                        Name = new ResourceManager(typeof(RazManager.Repository.Resources.RaceFormatType)).GetString(RaceFormatTypeId.AllDriversUniqueController.ToString()),
                        IndicatorEventUserCombined = true
                    },
                    new RaceFormatTypeSelect
                    {
                        Id = RaceFormatTypeId.StepUp,
                        Name = new ResourceManager(typeof(RazManager.Repository.Resources.RaceFormatType)).GetString(RaceFormatTypeId.StepUp.ToString()),
                        IndicatorEventUserCombined = false
                    },
                    new RaceFormatTypeSelect
                    {
                        Id = RaceFormatTypeId.Custom,
                        Name = new ResourceManager(typeof(RazManager.Repository.Resources.RaceFormatType)).GetString(RaceFormatTypeId.Custom.ToString()),
                        IndicatorEventUserCombined = false
                    }
                };
            }
        }
    }
}