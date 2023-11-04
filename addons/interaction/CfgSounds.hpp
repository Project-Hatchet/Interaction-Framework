#define SOUND(NAME,PATH) class RVAR(NAME) { name = QRVAR(NAME); sound[] = {QUOTE(\z\PREFIX\addons\COMPONENT\sounds\PATH.wss), 1, 1, 1}; titles[] = {}; }

class CfgSounds {
  SOUND(Switch_Sound,switch);
  SOUND(Switch_Sound_1,switch1);
  SOUND(Switch_Sound_2,switch2);
  SOUND(Switch_Sound_3,switch3);
  SOUND(Switch_Sound_4,switch4);
  SOUND(Switch_Sound_5,switch5);
  SOUND(HeavySwitch_Sound,heavySwitch);
  SOUND(dial_sound,dial);
};
