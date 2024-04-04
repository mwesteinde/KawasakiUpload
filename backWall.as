.PROGRAM backWall()
    inOptWindow = 1021
    inOptChimney = 1022
    PRINT "backwall"
    
    ;===========Half Inch tool===================
    CALL WstBckDiscHf ;Cut out disc both sides
    CALL WstBckVentHf
    CALL EstBckDiscHf ;Cut out disc both sides
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
    CALL changeTool(4, 0, intoolAutoChange)
    IF BITS(inOptWindow,1) THEN
        PRINT "STDWindow"
        CALL WstBckSTDWnBLNS
        CALL EstBckSTDWnBLEW
    ELSE
        PRINT "NoWindow"
    END


 .END
