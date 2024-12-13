.PROGRAM Option5()
    inOptFrontGlass = inProgOption1
    inOptFrontWood = inProgOption2
    inOptRearXL = inProgOption3
    inOptRearSmall = inProgOption4
    ;MUST have next three lines in all programs!
    .firstToolIndex = 0 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1  

    IF BITS(inOptFrontWood,1) THEN 
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

        CALL homeRobot
        CALL changeTool(0, 4)
    END

    IF BITS(inOptFrontGlass,1) THEN
        CALL WstFntGlsDrBlEW ;Glass door cut out with blade
        CALL WstFntGlsDrBlNS
        IF BITS(inWoodWidth51,1) THEN
            CALL WstFntHndlsBl51;Handles blade
        ELSE
            CALL WstFntHndlsBl475;Handles blade
        END

        CALL EstFntGlsDrBlNS ;Glass door cut out with blade
        IF BITS(inWoodWidth51,1) THEN
            CALL EstFntHndlsBl51;Handles blade
        ELSE
            CALL EstFntHndlsBl475;Handles blade
        END
        CALL EstFntGlsDrBlEW ;Glass door cut out with blade

        CALL homeRobot
        CALL changeTool(0, 4)
    END

    IF BITS(inOptRearXL, 1) THEN
        CALL WstBckSTDWnBLEW
        CALL WstBckSTDWnBLNS
        CALL EstBckSTDWnBLNS
        CALL EstBckSTDWnBLEW
        CALL homeRobot
        CALL changeTool(0, 4)
    END

    IF BITS(inOptRearSmall, 1) THEN
        CALL WstBckSmWnBLEW
        CALL WstBckSmWnBLNS
        CALL EstBckSmWnBLNS
        CALL EstBckSmWnBLEW
        CALL homeRobot
        CALL changeTool(0, 4)
    END
 .END
