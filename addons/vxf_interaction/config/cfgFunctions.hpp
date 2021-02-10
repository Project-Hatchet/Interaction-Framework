#include "\vxf_core\includes\configMacros.hpp"

class cfgFunctions {
  class vxf_interaction {
    class functions {
      class init {
        postInit = 1;
        file = "vxf_interaction\functions\init.sqf";
      };
      class preInit {
        preInit = 1;
        file = "vxf_interaction\functions\preInit.sqf";
      };

      class setup {
        file = "vxf_interaction\functions\setup.sqf";
      };
      class loadAll {
        file = "vxf_interaction\functions\loadAll.sqf";
      };
      class loadItem {
        file = "vxf_interaction\functions\loadItem.sqf";
      };
      class draw3D {
        file = "vxf_interaction\functions\draw3D.sqf";
      };
      class drawLabel {
        file = "vxf_interaction\functions\drawLabel.sqf";
      };
      class perFrame {
        file = "vxf_interaction\functions\perFrame.sqf";
      };
      class checkInteraction {
        file = "vxf_interaction\functions\checkInteraction.sqf";
      };
      class shutDown {
        file = "vxf_interaction\functions\shutDown.sqf";
      };

      class buttonDown {
        file = "vxf_interaction\functions\keys\buttonDown.sqf";
      };
      class buttonUp {
        file = "vxf_interaction\functions\keys\buttonUp.sqf";
      };
      class leverAnimate {
        file = "vxf_interaction\functions\keys\leverAnimate.sqf";
      };
      class knobAnimate {
        file = "vxf_interaction\functions\keys\knobAnimate.sqf";
      };
      class dragStart {
        file = "vxf_interaction\functions\keys\dragStart.sqf";
      };
      class drag {
        file = "vxf_interaction\functions\keys\drag.sqf";
      };
      class dragStop {
        file = "vxf_interaction\functions\keys\dragStop.sqf";
      };

      class pointCalculate {
        file = "vxf_interaction\functions\pointing\pointCalculate.sqf";
      };
      class pointDraw {
        file = "vxf_interaction\functions\pointing\pointDraw.sqf";
      };
      class pointNetSend {
        file = "vxf_interaction\functions\pointing\pointNetSend.sqf";
      };
      class pointNetReceive {
        file = "vxf_interaction\functions\pointing\pointNetReceive.sqf";
      };
      class pointStart {
        file = "vxf_interaction\functions\pointing\pointStart.sqf";
      };

      class scriptedInteract {
        file = "vxf_interaction\functions\scriptedInteract.sqf";
      };
    };
  };
};
