/*
 * vxf_interaction_fnc_init
 *
 * initialises some base variables for the interaction system
 */

//how many frames to wait between updates
vxf_interaction_updateEvery = 5;
vxf_interaction_updateIndex = 0;
vxf_interaction_currentButton = nil;
vxf_interaction_buttonHoldCode = nil;
vxf_interaction_buttonRadius = 1;
vxf_interaction_buttonHolding = false;
vxf_interaction_knobHolding = nil;
vxf_interaction_dragging = false;

vxf_point_icons = [];
vxf_point_lifetime = 2;
