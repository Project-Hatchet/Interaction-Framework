// #include "\hct_core\includes\configMacros.hpp"

class cfgFunctions {
  class hct_core {
    class functions {
      //startup
      class init {
        postInit = 1;
        file = "hatchet_hct_core\functions\init.sqf";
      };
      class getVehicleConfig {
        file = "hatchet_hct_core\functions\getVehicleConfig.sqf";
      };
      class startLoops {
        file = "hatchet_hct_core\functions\startLoops.sqf";
      };

      //events
      class vehicleChanged {
        file = "hatchet_hct_core\functions\events\vehicleChanged.sqf";
      };
      class perFrame {
        file = "hatchet_hct_core\functions\events\perFrame.sqf";
      };
      class perSecond {
        file = "hatchet_hct_core\functions\events\perSecond.sqf";
      };
      class perFixed {
        file = "hatchet_hct_core\functions\events\perFixed.sqf";
      };

      //module handling
      class load {
        file = "hatchet_hct_core\functions\modules\load.sqf";
      };
      class loadAll {
        file = "hatchet_hct_core\functions\modules\loadAll.sqf";
      };
      class start {
        file = "hatchet_hct_core\functions\modules\start.sqf";
      };
      class hasModule {
        file = "hatchet_hct_core\functions\modules\hasModule.sqf";
      };
      class shutDownAll {
        file = "hatchet_hct_core\functions\modules\shutDownAll.sqf";
      };
    };
  };
};
