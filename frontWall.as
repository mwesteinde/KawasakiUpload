.PROGRAM frontWall()
    ;Signals from PLC addresses
    inOptEcut = 1021
    inOptGlassDoor = 1022
    inOptDoorLock = 1023
    PRINT "frontwall"

    ;MUST have next six lines in all programs! Only change first tool index
    ;CHANGE
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    ;DONT CHANGE
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1
    
    IF -BITS(inOptEcut,1) THEN
        PRINT "Ecut"
        IF BITS(inWoodWidth51,1) THEN
            CALL WstFntEcutHf51 ;TODO: create
        ELSE
            CALL WstFntEcutHf475 ;TODO: create
        END
    ELSE
        PRINT "No Ecut"
    END

    IF BITS(inOptGlassDoor,1) == 0 THEN ; IF not glass door
        PRINT "Wood door"
        IF BITS(inWoodWidth51,1) THEN
            CALL WstFntHndlsHf51;Handles roughing
            CALL EstFntHndlsHf51
        ELSE
            CALL WstFntHndlsHf475
            CALL WstFntHndlsHf475
        END
    END

    CALL WstFntDiscHf ;Cut out disc both sides
    IF BITS(inWoodWidth51,1) == 0 THEN
        CALL WstFntDiscHfLst
    END

    CALL wstfntwngmrkhf
    
    CALL EstFntDiscHf ;Cut out disc both sides
    IF BITS(inWoodWidth51,1) == 0 THEN
        CALL EstFntDiscHfLst
    END

    CALL estfntwngmrkhf

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
        CALL WstFntLockHf; Lock cut out with half inch bit
    ELSE
        PRINT "No lock"
    END

    ;===========Blade===================
    CALL changeTool(4, 0) ; First argument: current tool. Second requested tool. 4 for half inch, 2 quarter, 0 sawblade

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
        IF BITS(inWoodWidth51,1) THEN
            CALL WstFntHndlsBl51;Handles blade
        ELSE
            CALL WstFntHndlsBl475;Handles blade
        END
        
        CALL EstFntWdDrBlNS;Wood door cut out north south with blade
        IF BITS(inWoodWidth51,1) THEN
            CALL EstFntHndlsBl51;Handles blade
        ELSE
            CALL EstFntHndlsBl475;Handles blade
        END
        CALL EstFntWdDrBlEW;Blade EW
    END
    CALL homeRobot
    CALL changeTool(0, 4)
 .END
