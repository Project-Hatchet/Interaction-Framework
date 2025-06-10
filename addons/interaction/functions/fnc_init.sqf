/*
 * hct_interaction_fnc_init
 *
 * initialises some base variables for the interaction system
 */

//how many frames to wait between updates
hct_interaction_updateEvery = 5;
hct_interaction_updateIndex = 0;
hct_interaction_currentButton = nil;
hct_interaction_buttonHoldCode = nil;
hct_interaction_buttonRadius = 1;
hct_interaction_buttonHolding = false;
hct_interaction_knobHolding = nil;
hct_interaction_dragging = false;

hct_point_icons = [];
hct_point_lifetime = 2;
