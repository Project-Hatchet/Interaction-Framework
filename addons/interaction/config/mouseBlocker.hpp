class RscStructuredText;
class hct_interaction_mouseBlocker {
  idd = 86005;
  movingEnable = 0;
  //duration = 9999999;
  enableSimulation = 1;
  //fadein = 0;
  //fadeout = 0;
  //hideCursor = 1;
  onLoad = "with uiNamespace do {hct_interaction_mouseBlocker = true; ctrlDelete hct_cursor_ctrl; hct_cursor_ctrl = nil;};";
  onUnload = "hct_interaction_cursorPos = [0.5,0.5]; with uiNamespace do {hct_interaction_mouseBlocker = false; ctrlDelete hct_cursor_ctrl; hct_cursor_ctrl = nil;};";
  class controls {
    class hct_interaction_mouseBlocker_label: RscStructuredText {
      idc = 86006;
    };
  };
};
