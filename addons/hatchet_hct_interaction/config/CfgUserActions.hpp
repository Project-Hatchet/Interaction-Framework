class CfgUserActions {
    class hct_interaction_use { // This class name is used for internal representation and also for the inputAction command.
        displayName = "Interact";
        tooltip = "Interact with current button";
        onActivate = "[vehicle call CBA_fnc_currentUnit, hct_interaction_currentButton] call hct_interaction_fnc_buttonDown";		// _this is always true.
        onDeactivate = "[vehicle call CBA_fnc_currentUnit, hct_interaction_currentButton] call hct_interaction_fnc_buttonUp";		// _this is always true.
    };
    class hct_interaction_back { // This class name is used for internal representation and also for the inputAction command.
        displayName = "Previous Setting";
        tooltip = "Set current switch or knob forward 1 position";
        onActivate = "hct_alternative_scroll_up = true;";		// _this is always true.
        onDeactivate = "hct_alternative_scroll_up = false;";		// _this is always true.
    };
    class hct_interaction_fore { // This class name is used for internal representation and also for the inputAction command.
        displayName = "Next Setting";
        tooltip = "Set current switch or knob back 1 position";
        onActivate = "hct_alternative_scroll_down = true;";		// _this is always true.
        onDeactivate = "hct_alternative_scroll_down = false;";		// _this is always true.
    };
    class hct_interaction_cursor { // This class name is used for internal representation and also for the inputAction command.
        displayName = "Mouse Cursor";
        tooltip = "Hold to use mouse cursor for interaction";
        onActivate = "_this call hct_interaction_fnc_keyCursor;";		// _this is always true.
        onDeactivate = "_this call hct_interaction_fnc_keyCursor;";		// _this is always true.
    };
};
