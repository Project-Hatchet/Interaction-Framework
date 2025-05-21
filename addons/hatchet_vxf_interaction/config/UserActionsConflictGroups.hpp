class UserActionsConflictGroups {
    class ActionGroups {
        vxf_interaction_ActionGroup[] = {
            "vxf_interaction_use",
            "vxf_interaction_back",
            "vxf_interaction_fore"
        };
    };

    class CollisionGroups {
        // Add your group to an existing collision group:
        //carMove[] += {"TAG_MyActionGroup"};

        // Or alternatively add your own collision group (which is usually preferrable):
        vxf_interaction_ActionGroupCollisions[] = {"basic", "vehBasic", "HeadMove", "aircraft", "heli", "vxf_interaction_ActionGroup"};
    };
};
