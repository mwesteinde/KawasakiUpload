.PROGRAM backWall()
    .inOptWindow = 1021
    .inOptChimney = 1022
    PRINT "backwall"

    IF BITS(.inProgramOptionWindow,1) THEN
        PRINT "STDWindow"
    ELSE
        PRINT "NoWindow"
    END
    IF BITS(.inProgramOptionChimney,1) THEN
        PRINT "Chimney"
    ELSE
        PRINT "NoChimney"
    END
    ; outToolSawblade = 
    ; outToolHalfUpcut = 
    ; outToolQuarterCompression = 
    ; inToolSawblade = 
    ; inToolHalfUpcut = 
    ; inToolQuarterCompression =
    ; WAIT SIG (-inToolHalfUpcut, -inToolSawblade, inToolQuarterCompression) ; Wait for quarter compression to be loaded
    ; EXECUTE backWallQuarter
    ; WAIT SIG (inToolHalfUpcut, -inToolSawblade, -inToolQuarterCompression) ; Wait for half inch` to be loaded
    ; EXECUTE backWallHalf
    ; WAIT SIG (-inToolHalfUpcut, inToolSawblade, inToolQuarterCompression)  ; Wait for sawblade to be loaded
    ; EXECUTE backWallSawbladeNS
    ; EXECUTE backWallSawbladeEW
    DELAY 5
 .END
