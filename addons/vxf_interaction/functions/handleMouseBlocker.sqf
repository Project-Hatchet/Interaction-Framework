vxf_interaction_cursorPos = getMousePosition;
if (inputAction "defaultAction" > 0 && !vxf_interaction_cursor_mouseDown) then {
	if (!isNil "vxf_interaction_currentButton") then {
		// systemChat "CLICKING";
		[vehicle player, vxf_interaction_currentButton] call vxf_interaction_fnc_buttonDown;
		vxf_interaction_cursor_mouseDown = true;
	};
};

if (inputAction "defaultAction" == 0 && vxf_interaction_cursor_mouseDown) then {
	if (!isNil "vxf_interaction_currentButton") then {
		// systemChat "UNCLICKING";
		[vehicle player, vxf_interaction_currentButton] call vxf_interaction_fnc_buttonUp;
		vxf_interaction_cursor_mouseDown = false;
	};
};