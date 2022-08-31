class vxf_interaction_mouseBlocker {
  idd = 86005;
  movingEnable = 0;
  //duration = 9999999;
  enableSimulation = 1;
  //fadein = 0;
  //fadeout = 0;
  //hideCursor = 1;
  onLoad = "uiNamespace setVariable [""vxf_interaction_mouseBlocker"",true];";
  onUnload = "uiNamespace setVariable [""vxf_interaction_mouseBlocker"",false]; vxf_interaction_cursorPos = [0.5,0.5];";
  //class controls { };
};
