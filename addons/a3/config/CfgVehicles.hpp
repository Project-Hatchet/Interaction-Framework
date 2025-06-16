#define RADIUS 0.1
#define POS_ENGINE 0,0,0
#define POS_LIGHTS 0,0,0

class CfgVehicles {
  class Car_F;
  #include "LSV_01.hpp"
  #include "Offroad_01.hpp"

  class Truck_F: Car_F {};
  #include "Van_02.hpp"

};
