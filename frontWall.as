.PROGRAM frontWall()
    ;Signals from PLC addresses
    inOptEcut = 1021
    inOptGlassDoor = 1022
    inOptHandles = 1023
    inOptHalfMoon = 1039
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

    IF -BITS(inOptHandles, 1) THEN ; IF not glass door
        PRINT "Handles"
        IF BITS(inWoodWidth51,1) THEN
            CALL WstFntHndlsHf51;Handles roughing
            CALL EstFntHndlsHf51
        ELSE
            CALL WstFntHndlsHf475
            CALL EstFntHndlsHf475
        END
    END

    CALL WstFntDiscHf ;Cut out disc both sides
    IF BITS(inWoodWidth51,1) == 0 AND BITS(inOptHalfMoon,1) == 1 THEN
        CALL WstFntDiscHfLst
    END

    CALL wstfntwngmrkhf
    
    CALL EstFntDiscHf ;Cut out disc both sides
    CALL estfntdischftop
    IF BITS(inWoodWidth51,1) == 0 AND BITS(inOptHalfMoon,1) == 1 THEN
        CALL EstFntDiscHfLst
    END

    CALL estfntwngmrkhf
    CALL estfntdischfbot
    IF -BITS(inOptGlassDoor,1) THEN
        PRINT "Glass door"
        ACCEL 40 ALWAYS
        DECEL 40 ALWAYS
        CALL WstFntGlassDrHf ;Glass door cut out with half inch bit
        CALL EstFntGlassDrHf ;Glass door cut out with half inch bit
        ACCEL 100 ALWAYS
        DECEL 100 ALWAYS
        CALL homeRobot
    ELSE
        PRINT "Wood door"
        CALL WstFntWdDrHf;Wood door cut out with half inch bit
        ACCEL 40 ALWAYS
        DECEL 40 ALWAYS
        CALL WstFntWdDrHfLst
        ACCEL 100 ALWAYS
        DECEL 100 ALWAYS
        CALL EstFntWdDrHf;Wood door cut out with half inch bit
        ACCEL 40 ALWAYS
        DECEL 40 ALWAYS
        CALL EstFntWdDrHfLst
        ACCEL 100 ALWAYS
        DECEL 100 ALWAYS
    END

; Not using door lock option
    ; IF -BITS(inOptHandles,1) THEN
    ;     PRINT "Lock"
    ;     CALL WstFntLockHf; Lock cut out with half inch bit
    ; ELSE
    ;     PRINT "No lock"
    ; END

    ;===========Blade===================
    CALL changeTool(4, 0) ; First argument: current tool. Second requested tool. 4 for half inch, 2 quarter, 0 sawblade

    IF -BITS(inOptGlassDoor,1) THEN
        PRINT "Glass door"
        CALL WstFntGlsDrBlEW ;Glass door cut out with blade
        CALL WstFntGlsDrBlNS ;Glass door cut out with blade
        IF BITS(inOptHandles, 1) THEN
            IF BITS(inWoodWidth51,1) THEN
                CALL WstFntHndlsBl51;Handles blade
            ELSE
                CALL WstFntHndlsBl475;Handles blade
            END
        END
        CALL EstFntGlsDrBlNS ;Glass door cut out with blade
        IF BITS(inOptHandles, 1) THEN
            IF BITS(inWoodWidth51,1) THEN
                CALL EstFntHndlsBl51;Handles blade
            ELSE
                CALL EstFntHndlsBl475;Handles blade
            END
        END
        CALL EstFntGlsDrBlEW ;Glass door cut out with blade
    ELSE
        PRINT "Wood door"
        CALL WstFntWdDrBlEW;Blade NS
        CALL WstFntWdDrBlNS;Wood door cut out north south with blade
        IF BITS(inOptHandles, 1) THEN
            IF BITS(inWoodWidth51,1) THEN
                CALL WstFntHndlsBl51;Handles blade
            ELSE
                CALL WstFntHndlsBl475;Handles blade
            END
        END
        
        CALL EstFntWdDrBlNS;Wood door cut out north south with blade
        IF BITS(inOptHandles, 1) THEN
            IF BITS(inWoodWidth51,1) THEN
                CALL EstFntHndlsBl51;Handles blade
            ELSE
                CALL EstFntHndlsBl475;Handles blade
            END
        END
        CALL EstFntWdDrBlEW;Blade EW
    END
    CALL homeRobot
    CALL changeTool(0, 4)
 .END
