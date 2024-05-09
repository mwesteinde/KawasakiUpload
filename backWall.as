.PROGRAM backWall()
    inOptWindow = 1021
    inOptChimney = 1022
    PRINT "backwall"

    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgramRunning, 1 = 1

    ;===========Half Inch tool===================
    CALL WstBckDiscHf ;Cut out disc both sides
    CALL wstbckwngmark
    CALL WstBckVentHf
    CALL EstBckDiscHf ;Cut out disc both sides
    CALL estbckwngmark
    CALL EstBckVentHf

    IF BITS(inOptWindow,1) THEN
        PRINT "STDWindow"
        CALL WstBckSTDWnHf
        CALL EstBckSTDWnHf
    ELSE
        PRINT "NoWindow"
    END
    IF BITS(inOptChimney,1) THEN
        PRINT "Chimney"
        CALL WstBckChimyHf
        CALL EstBckChimyHf
    ELSE
        PRINT "NoChimney"
    END

    ;===========Blade===================
    
    IF BITS(inOptWindow,1) THEN
        CALL changeTool(4, 0)
        PRINT "STDWindow"
        CALL WstBckSTDWnBLEW
        CALL WstBckSTDWnBLNS
        CALL EstBckSTDWnBLNS
        CALL EstBckSTDWnBLEW
    ELSE
        PRINT "NoWindow"
    END
    CALL homeRobot
 .END
