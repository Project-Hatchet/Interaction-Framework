class CfgMovesBasic {
  class ManActions {
    GVAR(salute) = QGVAR(salute);
  };

  class Actions {
      class NoActions: ManActions {
          GVAR(salute)[] = {QGVAR(salute), "Gesture"};
      };
  };
};

class CfgGesturesMale {
    class Default;

    class BlendAnims {
        GVAR(RightArm)[] = {
            "RightShoulder", 1,
            "RightArm", 1,
            "RightArmRoll", 1,
            "RightForeArm", 1,
            "RightForeArmRoll", 1,
            "RightHand", 1,
            "RightHandIndex1", 1,
            "RightHandIndex2", 1,
            "RightHandIndex3", 1,
            "RightHandMiddle1", 1,
            "RightHandMiddle2", 1,
            "RightHandMiddle3", 1,
            "RightHandPinky1", 1,
            "RightHandMiddle2", 1,
            "RightHandMiddle3", 1,
            "RightHandPinky1", 1,
            "RightHandPinky2", 1,
            "RightHandPinky3", 1,
            "RightHandRing", 1,
            "RightHandRing1", 1,
            "RightHandRing2", 1,
            "RightHandRing3", 1,
            "RightHandThumb1", 1,
            "RightHandThumb2", 1,
            "RightHandThumb3", 1
        };
    };

    class States {
        class GVAR(Salute): Default {
            actions = "NoActions";
            canPullTrigger = 0;
            connectAs = "";
            connectFrom[] = {};
            connectTo[] = {};
            disableWeapons = 0;
            enableBinocular = 1;
            enableMissile = 1;
            enableOptics = 0;
            equivalentTo = "";
            file = "\a3\anims_f\data\Anim\sdr\mov\erc\stp\ras\pst\AmovPercMstpSrasWpstDnon_Salute.rtm";
            forceAim = 0;
            headBobMode = 0;
            headBobStrength = 0;
            interpolateFrom[] = {};
            interpolateTo[] = {};
            interpolateWith[] = {};
            interpolationRestart = 0;
            interpolationSpeed = 6;
            looped = 0;
            mask = QGVAR(RightArm);
            minPlayTime = 0.5;
            preload = 0;
            ragdoll = 0;
            relSpeedMax = 1;
            relSpeedMin = 1;
            showHandGun = 0;
            showItemInHand = 0;
            showItemInRightHand = 0;
            showWeaponAim = 1;
            soundEdge[] = {0.5,1};
            soundEnabled = 1;
            soundOverride = "";
            speed = -2;
            static = 0;
            terminal = 0;
            Walkcycles = 1;
            weaponIK = 1;

            leftHandIKBeg = 1;
            leftHandIKCurve[] = {0, 1, 0.1, 0, 0.8, 0, 1, 1};
            leftHandIKEnd = 1;

            rightHandIKBeg = 1;
            rightHandIKCurve[] = {1};
            rightHandIKEnd = 1;
        };
    };
};
