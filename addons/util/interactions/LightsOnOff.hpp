class LightsOn {
  condition = "!isLightOn hct_vehicle"; // ! = "not" so if engine is not on it will display this button
  class lightsOnButton { // name class for the button
    positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
    position[] = {POSITION}; // coordinates to that button location
    label = "Lights On"; // what the button will show as text when you look at it
    radius = 0.1; // how close to the button you have to look to activate it
    buttonDown = "hct_vehicle setPilotLight true;"; // if the player presses the button this is what it will do
  }; // lightsOnButton^^
};
class LightsOff {
  condition = "isLightOn hct_vehicle"; // ! = "not" so if engine is not on it will display this button
  class lightsButton { // name class for the button
    positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
    position[] = {POSITION}; // coordinates to that button location
    label = "Lights Off"; // what the button will show as text when you look at it
    radius = 0.1; // how close to the button you have to look to activate it
    buttonDown = "hct_vehicle setPilotLight false;"; // if the player presses the button this is what it will do
  }; // lightsButton^^
};
