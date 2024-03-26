.PROGRAM backWall()
    .inOptWindow = 1021
    .inOptChimney = 1022
    PRINT "backwall"

    IF BITS(.inOptWindow,1) THEN
        PRINT "STDWindow"
    ELSE
        PRINT "NoWindow"
    END
    IF BITS(.inOptChimney,1) THEN
        PRINT "Chimney"
    ELSE
        PRINT "NoChimney"
    END
    DELAY 1
 .END
