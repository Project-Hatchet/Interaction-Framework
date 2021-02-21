class RVAR(EngineOn) {
  condition = QUOTE(!(isEngineOn (vehicle hatchet_player)));
  label = CSTRING(EngineOn_Label);
  radius = 0.3;
  buttonDown = QUOTE(vehicle hatchet_player engineOn true);
  action = "EngineOn";
};

class RVAR(EngineOff) {
  condition = QUOTE(isEngineOn (vehicle hatchet_player));
  label = CSTRING(EngineOff_Label);
  radius = 0.3;
  buttonDown = QUOTE(vehicle hatchet_player engineOn false);
  action = "EngineOff";
};

class RVAR(LightOn) {
  condition = QUOTE(!(isLightOn (vehicle hatchet_player)));
  label = CSTRING(LightsOn_Label);
  radius = 0.3;
  buttonDown = QUOTE(vehicle hatchet_player setPilotLight true);
  action = "LightOn";
};

class RVAR(LightOff) {
  condition = QUOTE(isLightOn (vehicle hatchet_player));
  label = CSTRING(LightsOff_Label);
  radius = 0.3;
  buttonDown = QUOTE(vehicle hatchet_player setPilotLight false);
  action = "LightOff";
};
