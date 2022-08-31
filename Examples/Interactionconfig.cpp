class CfgVehicles {
  class Car_F; // base class of the vehicle
  class LSV_01_base_F: Car_F { // change the config of the quad bike
    class vxf { // framework
     class interaction { // to let the framework know these are buttons
        class engineOnButton { // name class for the button
          condition = "!(isEngineOn (vehicle player))"; // ! = "not" so if engine is not on it will display this button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {-0.830169,0.891079,-0.733231}; // coordinates to that button location
          label = "$STR_ACTION_ENGINEON";
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "vehicle player engineOn true;"; // if the player presses the button this is what it will do
        }; // engineOnButton^^
        class engineOffButton {
          condition = "isEngineOn (vehicle player)"; // here the condition is "on" because there is no ! infront of it so if the engine is on it will display this button
          positionType = "coordinates";
          position[] = {-0.830169,0.891079,-0.733231};
          label = "$STR_ACTION_ENGINEOFF";
          radius = 0.3;
          buttonDown = "vehicle player engineOn false;";
        }; // engineOffButton^^
        class lightsOnbutton {
          condition = "!(isLighton(vehicle player))";
          positionType = "coordinates";
          position[] = {-0.829393,0.87302,-0.76552};
          label = "$STR_ACTION_LIGHTS_ON";
          radius = 0.3;
          buttonDown = "vehicle player setpilotLight true;";
        }; //lights on button ^^
         class lightsOffbutton {
          condition = "isLightOn (vehicle player)";
          positionType = "coordinates";
          position[] = {-0.829393,0.87302,-0.76552};
          label = "$STR_ACTION_LIGHTS_OFF";
          radius = 0.3;
          buttonDown = "vehicle player setpilotLight false;";
        }; // lights off button^^
      };
    };
  };
};
