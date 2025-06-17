class LSV_01_base_F: Car_F {
  class hct { // framework
    class interaction { // to let the framework know these are buttons
      #undef POSITION
      #define POSITION -0.717837,0.870723,-0.764648
      #include "\z\hct\addons\util\interactions\EngineOnOff.hpp"

      class Horn {
        //condition = "!isEngineOn (hct_vehicle)"; // ! = "not" so if engine is not on it will display this button
        class hornButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {-0.589712,0.682457,-0.735472}; // coordinates to that button location
          label = "Horn"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "[hct_vehicle, 'SportCarHorn'] call BIS_fnc_fire;"; // if the player presses the button this is what it will do
        }; // hornButton^^
      };

      #undef POSITION
      #define POSITION -0.828958,0.869669,-0.765562
      #include "\z\hct\addons\util\interactions\LightsOnOff.hpp"

    };
  };
};
