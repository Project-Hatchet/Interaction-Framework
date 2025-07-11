#define COMPONENT core
#define COMPONENT_BEAUTIFIED Core
#include "\z\HCT\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_CORE
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_CORE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CORE
#endif

#include "\z\HCT\addons\main\script_macros.hpp"

#define ANIMTYPE_NONE 0
#define ANIMTYPE_ANIM 1
#define ANIMTYPE_ASRC 2
#define ANIMTYPE_DOOR 3

#define MODULEINDEX_MODULENAME 0
#define MODULEINDEX_STARTUP 1
#define MODULEINDEX_SETUP 2
#define MODULEINDEX_PERFRAME 3
#define MODULEINDEX_PERSECOND 4
#define MODULEINDEX_PERFIXED 5
#define MODULEINDEX_DRAW3D 6
#define MODULEINDEX_SHUTDOWN 7
