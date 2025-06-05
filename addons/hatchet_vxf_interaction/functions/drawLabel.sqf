/*
 * vxf_interaction_fnc_drawLabel
 *
 * interaction button release functionality
 */

call (
  [
    vxf_interaction_fnc_drawLabel0,
    vxf_interaction_fnc_drawLabel1,
    vxf_interaction_fnc_drawLabel2
  ] select vxf_interaction_labelsMode
);
