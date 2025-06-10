class LSV_01_base_F: Car_F {
  class hct { // framework
    class interaction { // to let the framework know these are buttons
      #undef POS_ENGINE
      #define POS_ENGINE -0.717837,0.870723,-0.764648
      class EngineOff {
        condition = "isEngineOn (hct_vehicle)"; // here the condition is "on" because there is no ! infront of it so if the engine is on it will display this button
        class engineOffButton {
          positionType = "coordinates";
          position[] = {POS_ENGINE};
          label = "Engine off";
          radius = RADIUS;
          buttonDown = "hct_vehicle engineOn false;";
        }; // engineOffButton^^
      };
      class EngineOn {
        condition = "!isEngineOn (hct_vehicle)"; // ! = "not" so if engine is not on it will display this button
        class engineOnButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {POS_ENGINE}; // coordinates to that button location
          label = "Engine on"; // what the button will show as text when you look at it
          radius = RADIUS; // how close to the button you have to look to activate it
          buttonDown = "hct_vehicle engineOn true;"; // if the player presses the button this is what it will do
        }; // engineOnButton^^
      };

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

      #undef POS_LIGHTS
      #define POS_LIGHTS -0.828958,0.869669,-0.765562
      class LightsOn {
        condition = "!isLightOn hct_vehicle"; // ! = "not" so if engine is not on it will display this button
        class lightsOnButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {POS_LIGHTS}; // coordinates to that button location
          label = "Lights On"; // what the button will show as text when you look at it
          radius = RADIUS; // how close to the button you have to look to activate it
          buttonDown = "hct_vehicle setPilotLight true;"; // if the player presses the button this is what it will do
        }; // lightsOnButton^^
      };
      class LightsOff {
        condition = "isLightOn hct_vehicle"; // ! = "not" so if engine is not on it will display this button
        class lightsButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {POS_LIGHTS}; // coordinates to that button location
          label = "Lights Off"; // what the button will show as text when you look at it
          radius = RADIUS; // how close to the button you have to look to activate it
          buttonDown = "hct_vehicle setPilotLight false;"; // if the player presses the button this is what it will do
        }; // lightsButton^^
      };
    };
  };
};
