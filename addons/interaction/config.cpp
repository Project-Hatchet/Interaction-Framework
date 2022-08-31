#include "script_component.hpp"

class CfgPatches {
  class ADDON {
    name = COMPONENT_NAME;
    units[] = {};
    weapons[] = {};
    requiredVersion = REQUIRED_VERSION;
    requiredAddons[] = {"vxf_main"};
    author = "Project Hatchet";
    VERSION_CONFIG;
  };
};

#include "CfgActions.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgSounds.hpp"
