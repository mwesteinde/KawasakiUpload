.PROGRAM Option5()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 0 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1    


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
        
 .END
