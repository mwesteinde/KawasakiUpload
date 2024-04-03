.PROGRAM backWall()
    inOptWindow = 1021
    inOptChimney = 1022
    PRINT "backwall"
    
    ;===========Half Inch tool===================
    IF BITS(.inCurrentTool, 3) <> 1 THEN
        CALL changeTool(BITS(.inCurrentTool, 3), 1, intoolAutoChange)
    END

    CALL WstBckDiscHf ;Cut out disc both sides
    CALL WstBckVentHf
    CALL EstBckDiscHf ;Cut out disc both sides
    CALL WstBckVentHf

    IF BITS(inOptWindow,1) THEN
        PRINT "STDWindow"
        CALL WstBckSTDWnHf
        CALL EstBckSTDWndf
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
    CALL changeTool(1, 2, intoolAutoChange)
    IF BITS(inOptWindow,1) THEN
        PRINT "STDWindow"
        CALL WstBckSTDWnBLNS
        CALL EstBckSTDWnBLEW
    ELSE
        PRINT "NoWindow"
    END


 .END
