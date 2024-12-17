[] spawn {
    if (missionNamespace getVariable ["vxf_interaction_autoclose_actionmenu", false]) then {
      showCommandingMenu "RscMainMenu";
      showCommandingMenu "";
    };
  };