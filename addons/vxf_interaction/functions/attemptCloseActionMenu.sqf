[] spawn {
    if (missionNamespace getVariable ["vxf_uh60_interaction_autoclose_actionmenu", false]) then {
      showCommandingMenu "RscMainMenu";
      showCommandingMenu "";
    };
  };