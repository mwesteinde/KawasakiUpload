.PROGRAM Option5()
    inOptFrontGlass = inProgOption1
    inOptFrontWood = inProgOption2
    inOptRearXL = inProgOption3
    inOptRearSmall = inProgOption4
    ; First tool is set in firstTool[] in autostart.as and sent by programcontrol.pc
    ; when this program is selected. Update it there if the first tool changes.
    ; No start wait: programcontrol.pc only runs this program after the PLC start signal
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
        BITS outFinalToolChange, 1 = 1 ; Last tool change, nothing is cut after it: the PLC does not hold for Tool Loaded
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
        BITS outFinalToolChange, 1 = 1 ; Last tool change, nothing is cut after it: the PLC does not hold for Tool Loaded
        CALL changeTool(0, 4)
    END

    IF BITS(inOptRearXL, 1) THEN
        CALL WstBckSTDWnBLEW
        CALL WstBckSTDWnBLNS
        CALL EstBckSTDWnBLNS
        CALL EstBckSTDWnBLEW
        CALL homeRobot
        BITS outFinalToolChange, 1 = 1 ; Last tool change, nothing is cut after it: the PLC does not hold for Tool Loaded
        CALL changeTool(0, 4)
    END

    IF BITS(inOptRearSmall, 1) THEN
        CALL WstBckSmWnBLEW
        CALL WstBckSmWnBLNS
        CALL EstBckSmWnBLNS
        CALL EstBckSmWnBLEW
        CALL homeRobot
        BITS outFinalToolChange, 1 = 1 ; Last tool change, nothing is cut after it: the PLC does not hold for Tool Loaded
        CALL changeTool(0, 4)
    END
 .END
