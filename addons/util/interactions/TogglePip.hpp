class TogglePip {
  class TogglePipButton { // name class for the button
    positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
    position[] = {POSITION};
    label = "Toggle PiP"; // what the button will show as text when you look at it
    radius = 0.1; // how close to the button you have to look to activate it
    buttonDown = "[2] call hct_util_fnc_toggleRenderTargets"; // if the player presses the button this is what it will do
  };
};
