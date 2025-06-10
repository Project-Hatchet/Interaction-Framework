class UserActionsConflictGroups {
    class ActionGroups {
        hct_interaction_ActionGroup[] = {
            "hct_interaction_use",
            "hct_interaction_back",
            "hct_interaction_fore",
            "hct_interaction_cursor",
            "hct_interaction_cursorToggle"
        };
    };

    class CollisionGroups {
        // Add your group to an existing collision group:
        //carMove[] += {"HCT_MyActionGroup"};

        // Or alternatively add your own collision group (which is usually preferrable):
        hct_interaction_ActionGroupCollisions[] = {"basic", "vehBasic", "HeadMove", "aircraft", "heli", "hct_interaction_ActionGroup"};
    };
};
