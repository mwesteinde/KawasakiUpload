.PROGRAM frontWall()
    inOptEcut = 1021
    inOptGlassDoor = 1022
    inOptDoorLock = 1023
    PRINT "frontwall"

    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 3 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgramRunning, 1 = 1

    ; outFirstTool = 4
    ; WAIT SIG(inProgramStart)
    ; BITS outProgramRunning, 1 = 1
    ;===========Quarter Inch tool==================
    ; outfirstTool = 2
    ; IF -BITS(inOptEcut,1) THEN
    ;     PRINT "Ecut"
    ;     CALL WstFntEcutQtr;E-cut out with quarter inch bit
    ; ELSE
    ;     PRINT "No Ecut"
    ; END

    ; ;===========Half Inch tool===================
    ; CALL changeTool(2, 4)
    
    IF -BITS(inOptEcut,1) THEN
        PRINT "Ecut"
        CALL WstFntEcutHf;E-cut out with quarter inch bit
    ELSE
        PRINT "No Ecut"
    END

    IF BITS(inOptGlassDoor,1) == 0 THEN
        PRINT "Wood door"
        CALL WstFntHndlsHf;Handles roughing
    END

    CALL WstFntDiscHf ;Cut out disc both sides
    CALL wstfntwngmrk
    ; CALL WstFntDiscHfLst
    CALL EstFntDiscHf ;Cut out disc both sides
    CALL estfntwngmrk
    CALL EstFntDiscHfLst

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
        CALL WstFntWdDrBlEW;Blade NS
        CALL WstFntWdDrBlNS;Wood door cut out north south with blade
        CALL WstFntHndlsBl;Handles blade
        CALL EstFntWdDrBlNS;Wood door cut out north south with blade
        CALL EstFntWdDrBlEW;Blade EW
    END
    CALL homeRobot
 .END
