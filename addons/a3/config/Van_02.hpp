class Van_02_base_F: Truck_F {
  class hct_driver { // framework
    class interaction { // to let the framework know these are buttons

      #undef POSITION
      #define POSITION -0.733228,2.72307,-0.129473
      #include "\z\hct\addons\util\interactions\EngineOnOff.hpp"

      class Horn {
        //condition = "!isEngineOn (hct_vehicle)"; // ! = "not" so if engine is not on it will display this button
        class hornButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {-0.493691,2.58485,-0.0858202}; // coordinates to that button location
          label = "Horn"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "[hct_vehicle, 'CarHorn'] call BIS_fnc_fire;"; // if the player presses the button this is what it will do
        }; // hornButton^^
      };

      #undef POSITION
      #define POSITION -0.694991,2.64922,-0.133476
      #include "\z\hct\addons\util\interactions\LightsOnOff.hpp"

      class Door1Open {
        condition = "hct_vehicle animationSourcePhase 'Hide_Door_1_source' == 0 && {hct_vehicle animationSourcePhase 'Door_1_source' == 0}"; // ! = "not" so if engine is not on it will display this button
        class door1OpenButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {-0.890521,2.57587,-0.284436}; // coordinates to that button location
          label = "Open"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "hct_vehicle animateDoor ['Door_1_source', 1];"; // if the player presses the button this is what it will do
        }; // door1OpenButton^^
      };
      class Door1Close {
        condition = "hct_vehicle animationSourcePhase 'Hide_Door_1_source' == 0 && {hct_vehicle animationSourcePhase 'Door_1_source' == 1}"; // ! = "not" so if engine is not on it will display this button
        class door1OpenButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {-1.24115,2.61683,-0.275488}; // coordinates to that button location
          label = "Close"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "hct_vehicle animateDoor ['Door_1_source', 0];"; // if the player presses the button this is what it will do
        }; // door1CloseButton^^
      };

      #undef POSITION
      #define POSITION 0.00888563,2.54603,0.377698
      #include "\z\hct\addons\util\interactions\TogglePip.hpp"

    };
  };
};
