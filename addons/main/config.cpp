  #include "script_component.hpp"

class CfgPatches {
  class ADDON {
    name = QUOTE(COMPONENT);
    units[] = {};
    weapons[] = {};
    requiredVersion = REQUIRED_VERSION;
    requiredAddons[] = {"A3_Data_F_Tank_Loadorder"};
    author = "Project Hatchet";
    VERSION_CONFIG;
  };
};
