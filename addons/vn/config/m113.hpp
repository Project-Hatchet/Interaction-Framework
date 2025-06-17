class vn_armor_m113_base: APC_Tracked_01_base_F {};
class vn_armor_m113_01_base: vn_armor_m113_base {
  class hct_driver { // framework
    class interaction { // to let the framework know these are buttons
      #undef POSITION
      #define POSITION -1.10131,1.66283,-0.621141
      #include "\z\hct\addons\util\interactions\EngineOnOff.hpp"

      class Horn {
        //condition = "!isEngineOn (hct_vehicle)"; // ! = "not" so if engine is not on it will display this button
        class hornButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {-0.622199,1.9071,-0.558011}; // coordinates to that button location
          label = "Horn"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "[hct_vehicle, 'vn_m113_horn'] call BIS_fnc_fire;"; // if the player presses the button this is what it will do
        }; // hornButton^^
      };

      #undef POSITION
      #define POSITION -1.1049,1.68096,-0.58947
      #include "\z\hct\addons\util\interactions\LightsOnOff.hpp"

      class cargo_ramp {
        condition = "hct_vehicle animationSourcePhase 'inWater' < 0.1";
        class cargo_ramp {
          //clickSound = "hct_CabinDoor_Sound";
          position = "cargo_ramp_lever_axis";
          positionType = "anim";
          label = "Ramp";
          animation = "cargo_ramp";
          interactionCondition = "true";
          animStates[] = {0, 1};
          animLabels[] = {"Closed", "Open"};
          animStart = "hct_vehicle animateDoor ['rampCargo', [1, 0] select ((hct_vehicle doorPhase 'rampCargo') > 0.5)];";
          animEnd = "";
          radius = 0.1;
        }; // cargo_ramp
      };
    };
  }; // hct_driver

  class hct_cargo {
    class cargo_ramp {
      condition = "hct_vehicle animationSourcePhase 'inWater' < 0.1";
      class cargo_ramp {
        //clickSound = "hct_CabinDoor_Sound";
        position = "cargo_door_handle_int_axis";
        positionType = "anim";
        label = "Ramp";
        animation = "cargo_ramp";
        animStates[] = {0, 1};
        animLabels[] = {"Closed", "Open"};
        animStart = "hct_vehicle animateDoor ['rampCargo', [1, 0] select ((hct_vehicle doorPhase 'rampCargo') > 0.5)];";
        animEnd = "";
        radius = 0.1;
      }; // cargo_ramp
    };

    class Interaction {
      #undef POSITION
      #define POSITION -0.000680611,0.89321,-0.348099
      #include "\z\hct\addons\util\interactions\TogglePip.hpp"
    };

  }; // hct_cargo

  class hct_turret_0 {
    class Interaction {
      class Reload {
        class ReloadButton { // name class for the button
          positionType = "anim"; // type of position to mark location of button(can also be memory points)
          position = "mg1_ammobelt_shake_mov_axis";
          label = "Reload"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "[] call hct_util_fnc_reloadTurret"; // if the player presses the button this is what it will do
        }; // ReloadButton^^
      };
      class SearchLight {
        class SearchLightOnButton { // name class for the button
          positionType = "anim"; // type of position to mark location of button(can also be memory points)
          position = "mg1_light_1_pos"; // coordinates to that button location
          label = "SearchLight"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "hct_player action ['SearchlightOn', hct_vehicle];"; // if the player presses the button this is what it will do
        }; // SearchLightOnButton^^
      };

    };
  }; // hct_turret_0

  class hct_turret_1 {
    class Interaction {
      #undef POSITION
      #define POSITION -0.000680611,0.89321,-0.348099
      #include "\z\hct\addons\util\interactions\TogglePip.hpp"

    };
  }; // hct_turret_1

  class hct_turret_2 {
    class cargo_ramp {
      condition = "!isTurnedOut hct_player && {hct_vehicle animationSourcePhase 'inWater' < 0.1}";
      class cargo_ramp {
        //clickSound = "hct_CabinDoor_Sound";
        interactionCondition = "!isTurnedOut hct_player";
        position = "cargo_door_handle_int_axis";
        positionType = "anim";
        label = "Ramp";
        animation = "cargo_ramp";
        animStates[] = {0, 1};
        animLabels[] = {"Closed", "Open"};
        animStart = "hct_vehicle animateDoor ['rampCargo', [1, 0] select ((hct_vehicle doorPhase 'rampCargo') > 0.5)];";
        animEnd = "";
        radius = 0.1;
      }; // cargo_ramp
    };

    #undef POSITION
    #define POSITION -0.000680611,0.89321,-0.348099
    #include "\z\hct\addons\util\interactions\TogglePip.hpp"

  }; // hct_turret_2
  class hct_turret_3 {
    class cargo_ramp {
      condition = "!isTurnedOut hct_player && {hct_vehicle animationSourcePhase 'inWater' < 0.1}";
      class cargo_ramp {
        //clickSound = "hct_CabinDoor_Sound";
        interactionCondition = "!isTurnedOut hct_player";
        position = "cargo_door_handle_int_axis";
        positionType = "anim";
        label = "Ramp";
        animation = "cargo_ramp";
        animStates[] = {0, 1};
        animLabels[] = {"Closed", "Open"};
        animStart = "hct_vehicle animateDoor ['rampCargo', [1, 0] select ((hct_vehicle doorPhase 'rampCargo') > 0.5)];";
        animEnd = "";
        radius = 0.1;
      }; // cargo_ramp
    };

    #undef POSITION
    #define POSITION -0.000680611,0.89321,-0.348099
    #include "\z\hct\addons\util\interactions\TogglePip.hpp"

  }; // hct_turret_3

}; // vn_armor_m113_01_base

class vn_armor_m113_acav_m2_base: vn_armor_m113_01_base {

  class hct_driver { // framework
    class interaction { // to let the framework know these are buttons
      #undef POSITION
      #define POSITION -1.10162,1.6603,-0.670251
      #include "\z\hct\addons\util\interactions\EngineOnOff.hpp"

      class Horn {
        //condition = "!isEngineOn (hct_vehicle)"; // ! = "not" so if engine is not on it will display this button
        class hornButton { // name class for the button
          positionType = "coordinates"; // type of position to mark location of button(can also be memory points)
          position[] = {-0.622505,1.90457,-0.607121}; // coordinates to that button location
          label = "Horn"; // what the button will show as text when you look at it
          radius = 0.3; // how close to the button you have to look to activate it
          buttonDown = "[hct_vehicle, 'vn_m113_horn'] call BIS_fnc_fire;"; // if the player presses the button this is what it will do
        }; // hornButton^^
      };

      #undef POSITION
      #define POSITION -1.10521,1.67843,-0.63858
      #include "\z\hct\addons\util\interactions\LightsOnOff.hpp"

      class cargo_ramp {
        condition = "hct_vehicle animationSourcePhase 'inWater' < 0.1";
        class cargo_ramp {
          //clickSound = "hct_CabinDoor_Sound";
          position = "cargo_ramp_lever_axis";
          positionType = "anim";
          label = "Ramp";
          animation = "cargo_ramp";
          interactionCondition = "true";
          animStates[] = {0, 1};
          animLabels[] = {"Closed", "Open"};
          animStart = "hct_vehicle animateDoor ['rampCargo', [1, 0] select ((hct_vehicle doorPhase 'rampCargo') > 0.5)];";
          animEnd = "";
          radius = 0.1;
        }; // cargo_ramp
      };

    }; // interaction
  }; // hct_driver

  class hct_turret_2 {
    class Reload {
      condition = "true";
      class ReloadButton { // name class for the button
        positionType = "anim"; // type of position to mark location of button(can also be memory points)
        position = "mg2_belt_translate_axis";
        label = "Reload"; // what the button will show as text when you look at it
        radius = 0.3; // how close to the button you have to look to activate it
        buttonDown = "systemChat 'ok';"; // if the player presses the button this is what it will do
      }; // ReloadButton^^
    };
  };
  class hct_turret_3 {
    class Reload {
      condition = "true";
      class ReloadButton { // name class for the button
        positionType = "anim"; // type of position to mark location of button(can also be memory points)
        position = "mg3_belt_translate_axis"; // coordinates to that button location
        label = "Reload"; // what the button will show as text when you look at it
        radius = 0.3; // how close to the button you have to look to activate it
        buttonDown = "systemChat 'ok';"; // if the player presses the button this is what it will do
      }; // ReloadButton^^
    };
  };

};
