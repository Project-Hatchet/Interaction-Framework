<p align="center">
  <img src="https://github.com/user-attachments/assets/ed05131a-abff-4856-a285-6e55617a94cf" alt="Project Hatchet" width="400" height="400">
</p>
<p align="center">
    <a href="https://github.com/Project-Hatchet/Interaction-Framework/releases">
        <img src="https://img.shields.io/badge/Version-0.2.0-blue.svg?style=flat-square" alt="Framework Version">
    </a>
    <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2941986336">
        <img src="https://img.shields.io/steam/downloads/2941986336" alt="Framework" >
    </a>
    <a href="https://github.com/Project-Hatchet/Interaction-Framework/issues">
        <img src="https://img.shields.io/github/issues-raw/Project-Hatchet/interaction-framework.svg?label=Issues" alt="Issues">
    </a>
    <a href="https://discord.gg/58Pt5EGjvQ">
        <img src="https://img.shields.io/discord/487939925938012161.svg?label=Discord&colorB=7683D5" alt="Hatchet Discord">
    </a>
</p>
<p align="center">
# Hatchet Vehicle Framework
A vehicle scripting framework for Arma 3

This framework is in active development.

## Features
 - Allows simple config based binding of scripts to vehicles and seats(module system)
 - Allows config based implementation of vehicle interaction(interaction system)

## Vehicle & Seat Config
All configuration is provided by adding the `hct` subclass to the cfgVehicles class of your desired vehicle.
Configurations can be specified to specific seats using a specifier suffix. As the player gets in a vehicle or switches seats, the system will find the most specific configuration available for their seat. For example, when a `hct_driver` and a `hct` config are present, passengers will use the `hct` config, but the driver will use only modules and interactions found in `hct_driver`.

Config options
 - `hct`: applies to all players in a vehicle
 - `hct_driver`: applies to the driver(or pilot) of a vehicle
 - `hct_copilot`: applies to the turret of a vehicle which has `isCopilot` set to true
 - `hct_gunner`: applies to all gunners of a vehicle, this includes all door guns
 - `hct_cargo`: applies to all passengers
 - `hct_turret_` followed by the turret index: applies to the occupant of the turret with specified index, can apply to fire from vehicle seats.

Example:
```
class myMod_myVehicleName {
  class hct_driver {
    class modules {
      class driverSpecificModule {};
      class moduleForEveryone {};
    }; // modules
  }; // hct_driver
  class hct {
    class modules {
      class moduleForEveryone {};
    }; // modules
  }; // hct
}; // myMod_myVehicleName
```
## Modules
Modules are sets of scripts attached to vehicles, this allows you to execute scripts when the player is in a specific type of vehicle without having to worry about eventhandlers or keeping track of the vehicle or seat.
Modules are defined in the `modules` subClass of the hct config class.

Example:
```
class hct_driver {
  class modules {
    class customFuelManagementModule {
      startOnEnter = 1; // this makes it so the module is automatically started when the vehicle is entered
      setup = "_this call my_fuel_fnc_setup"; // this is run when the module is started
      perFrame = "_this call my_fuel_fnc_perFrame"; // this is run on every simulation frame
      perSecond = "_this call my_fuel_fnc_perSecond"; // this is run once per second
      perFixed = "_this call my_fuel_fnc_perFixed"; // this is run once per fixed time interval, default 0.2 seconds
      Draw3D = "_this call my_fuel_fnc_Draw3D"; // this is run once per draw frame
      shutDown = "_this call my_fuel_fnc_shutDown"; // this is called on shutdown, for example when the player leaves the vehicle, or the module is turned off
    };
  };
};
```

The example above displays all available configuration options for modules. For some additional information:

`setup`, `perSecond`, and `shutDown` all get `(array)[(object) vehicle]` passed to them as parameters(`_this`).

**perFrame:**

parameters(`_this`) passed along to the perFrame function are `(array)[(object)vehicle, (SCALAR)secondsBetweenFrames]`.

Use the per frame functions with caution, when they are not managed properly they can have a massive cost on performance. For data that needs to not be updated often, use the per second function(for example time of flight to a waypoint).

## Interaction
The interaction subclass is used to configure vehicle interaction on arma vehicles, currently allowing for buttons and animated switches/levers.

Interactions can be nested in each other, and in empty groups with conditions to disable interactions. Note that conditions will completely stop their labels from being rendered, this is largely useful for performance reasons.

Players will use their HCT interaction key for buttons, while using their default keybindings for action menu scrolling(default scroll wheel) for animated interactions.

**Simple buttons and conditions**
```
hct_driver {
 class interaction {
  class groupForEngineOn {
   condition = "isEngineOn _this";
   class aSimpleButton {
    interactionCondition = "damage _this < 0.5"; // this determines whether anything will happen when button is pushed, though it will still be visible.
    positionType="static"; // can be static or anim, when anim, position is recalculated, when static it stays the same relative to vehicle center.
    position="B_MFD3_1"; // selectionPosition for the interaction
    label="btn"; // label shown when hovering over
    radius=0.015; // radius for how "large" the button is
    buttonDown="systemChat ""button down"""; // runs when button is pressed
    buttonHold="systemChat str time"; // runs while button is held
    buttonUp="systemChat ""button up"""; // runs when button is released
   }; // aSimpleButton
  }; // groupForEngineOn
 }; // interaction
}; // hct_driver
```
The above example will show a button on the position `B_MFD3_1` with the label "btn" while the vehicle's engine is on. If the vehicle's health is below 50%, nothing will happen when the button is pushed.

In the example, `interactionCondition`, `buttonDown`, `buttonHold` and `buttonUp` are all optional and could be removed.

**Basic animated lever/switch**

```
class b_engpowercont1 {
  positionType="anim";
  position="b_engpowercont1";
  label="ENG POWER CONT 1";
  radius=0.035;

  animation="Lever_engpower1"; // the animation to play for the lever or switch
  animSpeed=0.5; // the speed to play the animation at
  animStates[] = {0,0.23,0.85}; // the "stop" points in the animation
  animLabels[] = {"OFF", "IDLE","FLY"}; // the labels associated with the positions the lever/switch can be in
  animStart="hint ""starting"";"; // the code to run when the animation starts
  animEnd="hint ""stopping"";"; // the code to run when the animation ends
}; // b_engpowercont1
```
The above example shows the configuration of an animated lever, the basic configuration is the same as a button, with the variables `positionType`, `position`, `label` and `radius`.

For animated levers/switches, the `animSpeed` variable is optional and defaults to 1. `animStart` and `animEnd` are also optional.

Animated lever and button configs can freely be mixed, animations are triggered by the nextAction and prevAction keys, which are the next and previous keys for the action menu(scroll up and down by default). This means you can configure a lever to both allow a push action, and a scroll(animate) action. This could be used to, for example, implement switches that in real life have a safety function that requires you to pull them outwards in order to move them to a different position.

parameters for animStart are `(array)[(object) vehicle]`. parameters for animEnd are `(array)[(object) vehicle, (string) animation end point label]`.

**Animated spinners/knobs**
```
 class Knob_LightUpperConsole {
   positionType="static";
   position="knob_lights_uprcsl";
   label="Upper Console Light";
   radius=0.025;

   animation="Knob_LightUpperConsole"; // animation for the control
   scrollIncrement = 0.2; // how much the animation is played when scrolling
   animSpeed = 1; // animation speed(when scrolling), 1 by default
   dragRange = 0.5; // how much distance needs to be dragged for the full animation range
   looping = 0; // does the animation loop
   animLimits[] = {0, 1}; // start and end of animation
   dragStart="hint ""starting"""; // code to run when animation starts
   dragging="hint ""dragging"""; // code to run while animating
   dragStop="hint ""stopping"""; // code to run when animation ends
   animationH="SearchLight_Turn"; // animation for the control when dragging horizontally
   animLimitsH[] = {0, 1}; // start and end phase of horizontal animation
 }; // Knob_LightUpperConsole
```

The above shows the configuration for a spinner/dragging control. It functions similarly to levers/switches, but instead of having fixed points it animates to, it can smoothly animate between its limits to allow fine adjustments. It can also be interacted with by holding down the interaction key on it and then dragging the cursor/screen away, upwards for increasing the animation, downward for decreasing.

Animated spinners/knobs can not be combined with lever or button controls, when button or lever controls are mixed with spinners, the buttons/levers are overwritten by the spinner/knob.

Parameters for dragStart are `(array)[(object) vehicle]`. dragStop and dragging are called with the parameters `(array)[(object) vehicle, (scalar) animationPhase]`.
The above shows
