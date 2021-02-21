#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(updateIndex) = 0;
GVAR(currentButton) = nil;
GVAR(buttonHoldCode) = nil;
GVAR(buttonRadius) = 1;
GVAR(buttonHolding) = false;
GVAR(knobHolding) = nil;
GVAR(dragging) = false;

GVAR(point_icons) = [];
GVAR(point_lifetime) = 2;

ADDON = true;
