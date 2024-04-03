.PROGRAM frontWall()
    inOptEcut = 1021
    inOptGlassDoor = 1022
    inOptDoorLock = 1023
    PRINT "frontwall"

    ;===========Quarter Inch tool===================
    CALL WstFntDrQtr ;Quarter inch door cuts

    IF -BITS(inOptEcut,1) THEN
        PRINT "Ecut"
        CALL WstFntEcutQtr;E-cut out with quarter inch bit
    ELSE
        PRINT "No Ecut"
    END

    CALL EstFntDrQtr ;Quarter inch door cuts
    ;===========Half Inch tool===================
    CALL changeTool(2, 4, intoolAutoChange)
    CALL WstFntDiscHf ;Cut out disc both sides
    CALL EstFntDiscHf ;Cut out disc both sides
    CALL WstFntDiscHfLst
    CALL WstFntDiscHfLst

    IF -BITS(inOptGlassDoor,1) THEN
        PRINT "Glass door"
        CALL WstFntGlassDrHf ;Glass door cut out with half inch bit
        CALL EstFntGlassDrHf ;Glass door cut out with half inch bit
    ELSE
        PRINT "Wood door"
        CALL WstFntWdDrHf;Wood door cut out with half inch bit
        CALL WstFntHndlsHf;Handles roughing
        CALL EstFntWdDrHf;Wood door cut out with half inch bit
    END

    IF -BITS(inOptDoorLock,1) THEN
        PRINT "Lock"
        CALL EstFntLockHf; Lock cut out with half inch bit
    ELSE
        PRINT "No lock"
    END

    ;===========Blade===================
    CALL changeTool(4, 0, intoolAutoChange)

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
