.PROGRAM backWall()
    inOptWindow = 1021 ;Bit addresses for window option
    inOptHandles = 1022
    inOptGlassDoorHandles = 1023
    inOptSmallWindow = 1039
    inOptChimney = 1040 ; NEW: Assigned a new address for the Chimney option
    PRINT "backwall"

    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

    ;Glass door handles option
    IF BITS(inOptGlassDoorHandles, 1) THEN
        IF BITS(inWoodWidth51,1) THEN
            CALL changeTool(4,2)
            CALL gldrhdlhlsqtr51
            CALL changeTool(2,4)
            CALL gldrhdlclrhf51
            CALL gldrhdllghf51
            CALL gldrhdlsmhf51
        ELSE
            CALL changeTool(4,2)
            CALL gldrhdlhlsqtr47
            CALL changeTool(2,4)
            CALL gldrhdlclrhf47
            CALL gldrhdllghf47
            CALL gldrhdlsmhf51
        END
    END

    ;===========Half Inch tool===================
    IF BITS(inOptHandles,1) THEN
        
        IF BITS(inWoodWidth51,1) THEN
            CALL WstFntHndlsHf51 ;TODO: create
            CALL EstFntHndlsHf51
        ELSE
            CALL WstFntHndlsHf475 ;TODO: create
            CALL EstFntHndlsHf475
        END
        CALL WstFntDiscHf
    ELSE
        CALL WstBckDiscHf ;Cut out disc both sides
    END
    CALL WstBckWngMrkHf
    CALL WstBckVentHf
    IF BITS(inOptHandles,1) THEN
        CALL EstFntDiscHf
    ELSE
        CALL EstBckDiscHf;Cut out disc both sides
    END
    CALL estfntdischfbot
    CALL EstBckVentHf
    CALL EstBckWngMrkHf
    CALL estfntdischftop

    IF BITS(inOptWindow,1) THEN
        PRINT "STDWindow"
        CALL WstBckSTDWnHf
        CALL EstBckSTDWnHf
    ELSE
        PRINT "NoWindow"
    END

    IF BITS(inOptSmallWindow,1) THEN
        PRINT "STDWindow"
        CALL WstBckSmWnHf
        CALL EstBckSmWnHf
    ELSE
        PRINT "NoWindow"
    END

      ; NEW SECTION FOR CHIMNEY LOGIC
  ; If the chimney option IS selected, then run the two stove programs.
  ; If it is NOT selected, this block is skipped.
  IF BITS(inOptChimney, 1) THEN
      PRINT "Chimney Option Selected - Running Stove Programs"
      CALL WstBackStveHf
      CALL EstBackStvHf
  ELSE
      PRINT "Standard Back - SKIPPING Stove Programs"
  END

    ;===========Blade===================
    IF BITS(inOptHandles,1) THEN
        CALL changeTool(4, 0)
        IF BITS(inWoodWidth51,1) THEN
            CALL WstFntHndlsBl51 ;TODO: create
            CALL EstFntHndlsBl51
        ELSE
            CALL WstFntHndlsBl475 ;TODO: create
            CALL EstFntHndlsBl475
        END
        IF BITS(inOptWindow,1) THEN
            PRINT "STDWindow"
            CALL WstBckSTDWnBLEW
            CALL WstBckSTDWnBLNS
            CALL EstBckSTDWnBLNS
            CALL EstBckSTDWnBLEW
        END
        IF BITS(inOptSmallWindow,1) THEN
            PRINT "SmallWindow"
            CALL WstBckSmWnBLEW
            CALL WstBckSmWnBLNS
            CALL EstBckSmWnBLNS
            CALL EstBckSmWnBLEW
        END

        CALL changeTool(0,4)
    ELSE
        IF BITS(inOptWindow,1) OR BITS(inOptSmallWindow,1) THEN
            CALL changeTool(4, 0)
            IF BITS(inOptWindow,1) THEN
                PRINT "STDWindow"
                CALL WstBckSTDWnBLEW
                CALL WstBckSTDWnBLNS
                CALL EstBckSTDWnBLNS
                CALL EstBckSTDWnBLEW
            ELSE
                PRINT "SmallWindow"
                CALL WstBckSmWnBLEW
                CALL WstBckSmWnBLNS
                CALL EstBckSmWnBLNS
                CALL EstBckSmWnBLEW
            END
            CALL changeTool(0, 4)
        ELSE
            PRINT "NoWindow"
            CALL homeRobot
        END
    END
 .END
