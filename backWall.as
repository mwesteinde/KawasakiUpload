.PROGRAM backWall()
    inOptWindow = 1021 ;Bit addresses for window option
    inOptChimney = 1022
    PRINT "backwall"

    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

    ;===========Half Inch tool===================
    CALL WstBckDiscHf ;Cut out disc both sides
    CALL WstBckWngMrkHf
    CALL WstBckVentHf
    CALL EstBckDiscHf ;Cut out disc both sides
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

    ;===========Blade===================
    
    IF BITS(inOptWindow,1) THEN
        CALL changeTool(4, 0)
        PRINT "STDWindow"
        CALL WstBckSTDWnBLEW
        CALL WstBckSTDWnBLNS
        CALL EstBckSTDWnBLNS
        CALL EstBckSTDWnBLEW
        CALL changeTool(0, 4)
    ELSE
        PRINT "NoWindow"
        CALL homeRobot
    END
 .END
