hct_interaction_cursorPos = getMousePosition;
if (inputAction "defaultAction" > 0 && !hct_interaction_cursor_mouseDown) then {
	if (!isNil "hct_interaction_currentButton") then {
		// systemChat "CLICKING";
		[vehicle ace_player, hct_interaction_currentButton] call hct_interaction_fnc_buttonDown;
		hct_interaction_cursor_mouseDown = true;
	};
};

if (inputAction "defaultAction" == 0 && hct_interaction_cursor_mouseDown) then {
	if (!isNil "hct_interaction_currentButton") then {
		// systemChat "UNCLICKING";
		[vehicle ace_player, hct_interaction_currentButton] call hct_interaction_fnc_buttonUp;
		hct_interaction_cursor_mouseDown = false;
	};
};
