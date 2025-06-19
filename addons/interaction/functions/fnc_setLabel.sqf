/*
 * hct_interaction_fnc_setLabel
 *
 * set the label text
 */

params ["_prev", "_next"];

uiNamespace setVariable ["hct_interaction_drawLabel2_text_prev", _prev];
uiNamespace setVariable ["hct_interaction_drawLabel2_text_next", _next];

with uiNamespace do {
  hct_cursor_ctrl ctrlSetStructuredText parseText format [
    "<t color='%4' size='1' align='center'>%1<br/><br/>%2<br/><br/><br/>%3</t>",
    hct_interaction_drawLabel2_text_prev,
    hct_interaction_cursorText,
    hct_interaction_drawLabel2_text_next,
    hct_interaction_cursorColor
  ];
  hct_cursor_ctrl ctrlSetPosition [(-safeZoneX)+(hct_interaction_cursorPos # 0) - (safeZoneW / 2),((hct_interaction_cursorPos # 1) - 0.1),1,1];
  hct_cursor_ctrl ctrlCommit 0;
};
