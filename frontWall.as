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

    ; outToolSawblade = 
    ; outToolHalfUpcut = 
    ; outToolQuarterCompression = 
    ; inToolSawblade = 
    ; inToolHalfUpcut = 
    ; inToolQuarterCompression =
    ; WAIT SIG (-inToolHalfUpcut, -inToolSawblade, inToolQuarterCompression) ; Wait for quarter compression to be loaded
    ; EXECUTE frontWallQuarter
    ; WAIT SIG (inToolHalfUpcut, -inToolSawblade, -inToolQuarterCompression) ; Wait for half inch` to be loaded
    ; EXECUTE frontWallHalf
    ; WAIT SIG (-inToolHalfUpcut, inToolSawblade, inToolQuarterCompression)  ; Wait for sawblade to be loaded
    ; EXECUTE frontWallSawbladeNS
    ; EXECUTE frontWallSawbladeEW
    DELAY 5
 .END
