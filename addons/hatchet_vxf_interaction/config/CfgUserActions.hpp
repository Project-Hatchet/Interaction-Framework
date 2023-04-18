class CfgUserActions {
    class vxf_interaction_use { // This class name is used for internal representation and also for the inputAction command.
        displayName = "Interact";
        tooltip = "Interact with current button";
        onActivate = "[vehicle call CBA_fnc_currentUnit, vxf_interaction_currentButton] call vxf_interaction_fnc_buttonDown";		// _this is always true.
        onDeactivate = "[vehicle call CBA_fnc_currentUnit, vxf_interaction_currentButton] call vxf_interaction_fnc_buttonUp";		// _this is always true.
    };
    class vxf_interaction_back { // This class name is used for internal representation and also for the inputAction command.
        displayName = "Previous Setting";
        tooltip = "Set current switch or knob forward 1 position";
        onActivate = "vxf_alternative_scroll_up = true;";		// _this is always true.
        onDeactivate = "vxf_alternative_scroll_up = false;";		// _this is always true.
    };
    class vxf_interaction_fore { // This class name is used for internal representation and also for the inputAction command.
        displayName = "Next Setting";
        tooltip = "Set current switch or knob back 1 position";
        onActivate = "vxf_alternative_scroll_down = true;";		// _this is always true.
        onDeactivate = "vxf_alternative_scroll_down = false;";		// _this is always true.
    };
};
