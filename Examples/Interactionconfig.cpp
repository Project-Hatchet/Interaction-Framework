class cfgVehicles {
  class vtx_uh60 {
    class vtx {
      class interaction {
        class mfdControlsGroup {
          condition="engineOn";
          class mfdPilotLeftSwitchOn {
            position="mfdPilotLeftSwitchOn";
            type="switch";
            code="[""mfdPilotLeft""] call vtx_uh60_dashboard_fnc_mfdPower;";
          };
          class apucont {
            positionType="static";
            position="b_apucont";
            label="APU CONT";
            radius=0.025;
            animation="Switch_apucont";
            animSpeed=4;
            animStates[] = {0.5, 0};
            animLabels[] = {"OFF", "ON"};
            animEnd="_this call vtx_adsfjkl_engine_fnc_apuState";
          }; // apucont
          class knob {
            positionType="static";
            position="b_knob";
            label="TEST KNOB";
            radius=0.05;
            animation="anim_knob";
            scrollSteps = 10;
            dragRange = 0.5;
            dragLooping = 0;
            animLimits[] = {0, 1};
            dragStart="hint ""starting""";
            dragging="hint ""dragging""";
            dragStop="hint ""stopping""";
          }; // knob
        };
      };
      class modules {
        class advancedStart {
          startOnEnter=1;
          perSecond="external_fnc_perSecond";
        };
      };
    };
  };
};
