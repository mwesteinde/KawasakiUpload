.PROGRAM frontWall()
    PRINT "frontwall"

    ;===========Quarter Inch tool===================
    IF BITS(inCurrentTool, 3) <> 0 THEN
        CALL changeTool(BITS(inCurrentTool, 3), 0, intoolAutoChange)
    END

    CALL WstFntWlDrQtr ;Quarter inch door cuts

    IF -BITS(inOptEcut,1) THEN
        PRINT "Ecut"
        CALL WstFntEcutQtr;E-cut out with quarter inch bit
    ELSE
        PRINT "No Ecut"
    END

    CALL EstFntWlQuarter ;Quarter inch door cuts

    ;===========Half Inch tool===================
    CALL changeTool(0, 1, intoolAutoChange)
    CALL WstFntDiscHf ;Cut out disc both sides
    CALL EstFntDiscHf ;Cut out disc both sides

    IF -BITS(inOptGlassDoor,1) THEN
        PRINT "Glass door"
        CALL WstFntGlassDrHf ;Glass door cut out with half inch bit
        CALL EstFntGlassDrHf ;Glass door cut out with half inch bit
    ELSE
        PRINT "Wood door"
        CALL WstFntWoodDrHf;Wood door cut out with half inch bit
        CALL WstFntHndlsHf;Handles roughing
        CALL EstFntWoodDrHf;Wood door cut out with half inch bit
    END

    IF -BITS(inOptEcut,1) THEN
        PRINT "Ecut"
        CALL WstFntEcutHf;E-cut out with half inch bit
    ELSE
        PRINT "No Ecut"
    END

    IF -BITS(inOptDoorLock,1) THEN
        PRINT "Lock"
        CALL EstFntLockHf; Lock cut out with half inch bit
    ELSE
        PRINT "No lock"
    END

    ;===========Blade===================
    CALL changeTool(1, 2, intoolAutoChange)

    IF -BITS(inOptGlassDoor,1) THEN
        PRINT "Glass door"
        CALL WstFntGlsDrBlNS ;Glass door cut out with blade
        CALL EstFntGlsDrBlEW ;Glass door cut out with blade
    ELSE
        PRINT "Wood door"
        CALL WstFntWdDrBlEW;Blade NS
        CALL EstFntWdDrBlEW;Blade EW
        CALL EstFntWdDrBlNS;Wood door cut out north south with blade
        CALL WstFntWdDrBlNS;Wood door cut out north south with blade
        CALL WstFntHndlsBl;Handles blade
    END



 .END
