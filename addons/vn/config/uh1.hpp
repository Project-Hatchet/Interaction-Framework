class vn_air_uh1_01_base: vn_helicopter_base {
  class hct { // framework
    class interaction { // to let the framework know these are buttons
      #undef POS_ENGINE
      #define POS_ENGINE -0.733228,2.72307,-0.129473
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
          position[] = {-0.493691,2.58485,-0.0858202}; // coordinates to that button location
          label = "Horn"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "[hct_vehicle, 'CarHorn'] call BIS_fnc_fire;"; // if the player presses the button this is what it will do
        }; // hornButton^^
      };

      #undef POS_LIGHTS
      #define POS_LIGHTS -0.694991,2.64922,-0.133476
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

    };
  };

  class hct_cargo {
      class interaction {
          class l_door {
              //clickSound = "hct_CabinDoor_Sound";
              position="door_main_l";
              positionType="anim";
              label="Left Door";
              animation="door_main_l";
              interactionCondition="true";
              animStates[] = {0, 1};
              animLabels[] = {"Closed", "Open"};
              animStart = "hct_vehicle animateDoor ['door_main_l_source', [1, 0] select ((hct_vehicle animationSourcePhase 'door_main_l_source') > 0.5)];";
              animEnd = "";
              radius=0.1;
              animSpeed="true";
          }; // l_door
          class r_door {
              //clickSound = "hct_CabinDoor_Sound";
              position="door_main_r";
              positionType="anim";
              label="Right Door";
              animation="door_main_r";
              interactionCondition="true";
              animStates[] = {0, 1};
              animLabels[] = {"Closed", "Open"};
              animStart = "hct_vehicle animateDoor ['door_main_r_source', [1, 0] select ((hct_vehicle animationSourcePhase 'door_main_r_source') > 0.5)];";
              animEnd = "";
              radius=0.1;
              animSpeed="true";
          }; // r_door
      };
  };

};
