#include "script_component.hpp"
/*
  hct_core_fnc_getAnimPhase
*/
params ["_vehicle", "_animName"];

call [
  {_this},
  {_vehicle animationPhase _animName},
  {_vehicle animationSourcePhase _animName},
  {_vehicle doorPhase _animName}
] select (hct_core_animTypeMap getOrDefaultCall [
  typeOf _vehicle + _animName,
  {
    _type = ANIMTYPE_NONE;
    if (isClass (configOf _vehicle >> "AnimationSources" >> _animName)) then {
      if (getText (configOf _vehicle >> "AnimationSources" >> _animName >> "source") == "door") then {
        _type = ANIMTYPE_DOOR;
      };
      _type = ANIMTYPE_ASRC;
    };
    if (_animName in animationNames _vehicle) then {
      _type = ANIMTYPE_ANIM;
    };
    _type
  }, true
])
