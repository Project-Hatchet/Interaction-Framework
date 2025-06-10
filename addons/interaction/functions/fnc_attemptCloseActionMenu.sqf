[] spawn {
    if (missionNamespace getVariable ["hct_interaction_autoclose_actionmenu", false]) then {
      showCommandingMenu "RscMainMenu";
      showCommandingMenu "";
    };
  };
