#include "\vxf_core\includes\configMacros.hpp"

class cfgFunctions {
  class vxf_core {
    class functions {
      //startup
      class init {
        postInit = 1;
        file = "vxf_core\functions\init.sqf";
      };
      class getVehicleConfig {
        file = "vxf_core\functions\getVehicleConfig.sqf";
      };
      class startLoops {
        file = "vxf_core\functions\startLoops.sqf";
      };

      //events
      class vehicleChanged {
        file = "vxf_core\functions\events\vehicleChanged.sqf";
      };
      class perFrame {
        file = "vxf_core\functions\events\perFrame.sqf";
      };
      class perSecond {
        file = "vxf_core\functions\events\perSecond.sqf";
      };

      //module handling
      class load {
        file = "vxf_core\functions\modules\load.sqf";
      };
      class loadAll {
        file = "vxf_core\functions\modules\loadAll.sqf";
      };
      class start {
        file = "vxf_core\functions\modules\start.sqf";
      };
      class hasModule {
        file = "vxf_core\functions\modules\hasModule.sqf";
      };
      class shutDownAll {
        file = "vxf_core\functions\modules\shutDownAll.sqf";
      };
    };
  };
};
