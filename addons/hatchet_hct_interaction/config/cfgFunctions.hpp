// #include "\hct_core\includes\configMacros.hpp"

class cfgFunctions {
  class hct_interaction {
    class functions {
      class init {
        postInit = 1;
        file = "hatchet_hct_interaction\functions\init.sqf";
      };
      class preInit {
        preInit = 1;
        file = "hatchet_hct_interaction\functions\preInit.sqf";
      };

      class setup {
        file = "hatchet_hct_interaction\functions\setup.sqf";
      };
      class loadAll {
        file = "hatchet_hct_interaction\functions\loadAll.sqf";
      };
      class loadItem {
        file = "hatchet_hct_interaction\functions\loadItem.sqf";
      };
      class draw3D {
        file = "hatchet_hct_interaction\functions\draw3D.sqf";
      };
      class drawLabel {
        file = "hatchet_hct_interaction\functions\drawLabel.sqf";
      };
      class setLabel {
        file = "hatchet_hct_interaction\functions\setLabel.sqf";
      };
      class perFrame {
        file = "hatchet_hct_interaction\functions\perFrame.sqf";
      };
      class checkInteraction {
        file = "hatchet_hct_interaction\functions\checkInteraction.sqf";
      };
      class shutDown {
        file = "hatchet_hct_interaction\functions\shutDown.sqf";
      };
      class keyCursor {
        file = "hatchet_hct_interaction\functions\keyCursor.sqf";
      };
      class handleMouseBlocker {
        file = "hatchet_hct_interaction\functions\handleMouseBlocker.sqf";
      };
      class attemptCloseActionMenu {
        file = "hatchet_hct_interaction\functions\attemptCloseActionMenu.sqf";
      };

      class buttonDown {
        file = "hatchet_hct_interaction\functions\keys\buttonDown.sqf";
      };
      class buttonUp {
        file = "hatchet_hct_interaction\functions\keys\buttonUp.sqf";
      };
      class leverAnimate {
        file = "hatchet_hct_interaction\functions\keys\leverAnimate.sqf";
      };
      class knobAnimate {
        file = "hatchet_hct_interaction\functions\keys\knobAnimate.sqf";
      };
      class dragStart {
        file = "hatchet_hct_interaction\functions\keys\dragStart.sqf";
      };
      class drag {
        file = "hatchet_hct_interaction\functions\keys\drag.sqf";
      };
      class dragStop {
        file = "hatchet_hct_interaction\functions\keys\dragStop.sqf";
      };

      class pointCalculate {
        file = "hatchet_hct_interaction\functions\pointing\pointCalculate.sqf";
      };
      class pointDraw {
        file = "hatchet_hct_interaction\functions\pointing\pointDraw.sqf";
      };
      class pointNetSend {
        file = "hatchet_hct_interaction\functions\pointing\pointNetSend.sqf";
      };
      class pointNetReceive {
        file = "hatchet_hct_interaction\functions\pointing\pointNetReceive.sqf";
      };
      class pointStart {
        file = "hatchet_hct_interaction\functions\pointing\pointStart.sqf";
      };

      class scriptedInteract {
        file = "hatchet_hct_interaction\functions\scriptedInteract.sqf";
      };
    };
  };
};
