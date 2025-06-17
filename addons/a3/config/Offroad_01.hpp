class Offroad_01_base_F: Car_F {
  class hct { // framework
    class interaction { // to let the framework know these are buttons

      #undef POSITION
      #define POSITION -0.354693,0.725035,-0.133877
      #include "\z\hct\addons\util\interactions\EngineOnOff.hpp"

      class Horn {
        //condition = "!isEngineOn (hct_vehicle)"; // ! = "not" so if engine is not on it will display this button
        class hornButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {-0.423183,0.612029,0.027044}; // coordinates to that button location
          label = "Horn"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "[hct_vehicle, 'SportCarHorn'] call BIS_fnc_fire;"; // if the player presses the button this is what it will do
        }; // hornButton^^
      };

      #undef POSITION
      #define POSITION -0.694847,0.787173,-0.223982
      #include "\z\hct\addons\util\interactions\LightsOnOff.hpp"

    };
  };
};
