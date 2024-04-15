.PROGRAM frontWall()
    inOptEcut = 1021
    inOptGlassDoor = 1022
    inOptDoorLock = 1023
    PRINT "frontwall"

    ;===========Quarter Inch tool===================
    ; CALL WstFntDrQtr ;Quarter inch door cuts
    ; CALL wstfntwngmrk

    IF -BITS(inOptEcut,1) THEN
        PRINT "Ecut"
        ; CALL WstFntEcutQtr;E-cut out with quarter inch bit
    ELSE
        PRINT "No Ecut"
    END

    CALL EstFntDrQtr ;Quarter inch door cuts
    ; CALL Estfntwngmrk
    ;===========Half Inch tool===================
    CALL changeTool(2, 4, intoolAutoChange)

    IF BITS(inOptGlassDoor,1) == 0 THEN
        PRINT "Wood door"
        CALL WstFntHndlsHf;Handles roughing
    END

    CALL WstFntDiscHf ;Cut out disc both sides
    ; CALL WstFntDiscHfLst
    CALL EstFntDiscHf ;Cut out disc both sides
    ; CALL EstFntDiscHfLst

    IF -BITS(inOptGlassDoor,1) THEN
        PRINT "Glass door"
        CALL WstFntGlassDrHf ;Glass door cut out with half inch bit
        CALL EstFntGlassDrHf ;Glass door cut out with half inch bit
    ELSE
        PRINT "Wood door"
        CALL WstFntWdDrHf;Wood door cut out with half inch bit
        CALL WstFntWdDrHfLst
        CALL EstFntWdDrHf;Wood door cut out with half inch bit
        CALL EstFntWdDrHfLst
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
        CALL WstFntGlsDrBlEW ;Glass door cut out with blade
        CALL WstFntGlsDrBlNS ;Glass door cut out with blade
        CALL EstFntGlsDrBlNS ;Glass door cut out with blade
        CALL EstFntGlsDrBlEW ;Glass door cut out with blade
    ELSE
        PRINT "Wood door"
        ; CALL WstFntWdDrBlEW;Blade NS
        CALL WstFntWdDrBlNS;Wood door cut out north south with blade
        CALL WstFntHndlsBl;Handles blade
        CALL EstFntWdDrBlNS;Wood door cut out north south with blade
        CALL EstFntWdDrBlEW;Blade EW
    END
    CALL homeRobot
 .END
