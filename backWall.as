.PROGRAM backWall()
    inOptWindow = 1021
    inOptChimney = 1022
    PRINT "backwall"
    
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
        CALL changeTool(4, 0, intoolAutoChange)
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
