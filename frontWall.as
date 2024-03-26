.PROGRAM frontWall()
    .inOptEcut = 1021
    .inOptGlassDoor = 1022
    .inOptDoorLock = 1023
    PRINT "frontwall"
    IF -BITS(.inOptEcut,1) THEN
        PRINT "Ecut"
    ELSE
        PRINT "No Ecut"
    END
    IF -BITS(.inOptGlassDoor,1) THEN
        PRINT "Glass door"
    ELSE
        PRINT "Wood door"
    END
    IF -BITS(.inOptDoorLock,1) THEN
        PRINT "Lock"
    ELSE
        PRINT "No lock"
    END
    DELAY 1
 .END
