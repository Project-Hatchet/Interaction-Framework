class EngineOff {
  condition = "isEngineOn (hct_vehicle)"; // here the condition is "on" because there is no ! infront of it so if the engine is on it will display this button
  class engineOffButton {
    positionType = "coordinates";
    position[] = {POSITION};
    label = "Engine off";
    radius = 0.1;
    buttonDown = "hct_vehicle engineOn false;";
  }; // engineOffButton^^
};
class EngineOn {
  condition = "!isEngineOn (hct_vehicle)"; // ! = "not" so if engine is not on it will display this button
  class engineOnButton { // name class for the button
    positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
    position[] = {POSITION}; // coordinates to that button location
    label = "Engine on"; // what the button will show as text when you look at it
    radius = 0.1; // how close to the button you have to look to activate it
    buttonDown = "hct_vehicle engineOn true;"; // if the player presses the button this is what it will do
  }; // engineOnButton^^
};
