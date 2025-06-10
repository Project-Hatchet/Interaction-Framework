/*
 * vxf_interaction_fnc_setLabel
 *
 * set the label text
 */

params ["_prev", "_next"];

uiNamespace setVariable ["vxf_interaction_drawLabel2_text_prev", _prev];
uiNamespace setVariable ["vxf_interaction_drawLabel2_text_next", _next];

with uiNamespace do {
  vtx_cursor_ctrl ctrlSetStructuredText parseText format [
    "<t size='1' align='center'>%1<br/><br/>%2<br/><br/><br/>%3</t>",
    vxf_interaction_drawLabel2_text_prev,
    ".",
    vxf_interaction_drawLabel2_text_next
  ];
  vtx_cursor_ctrl ctrlSetPosition [(-safeZoneX)+(vxf_interaction_cursorPos # 0) - (safeZoneW / 2),((vxf_interaction_cursorPos # 1) - 0.1),1,1];
  vtx_cursor_ctrl ctrlCommit 0;
};
