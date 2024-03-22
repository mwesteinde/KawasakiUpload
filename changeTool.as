.PROGRAM changeTool(.currentTool, .requestedTool)
    .inToolReleased = 1008
    .inToolGrabbed = 1009
    .outCurrentTool = 107
    .outRequestTool = 110
    .outReleaseTool = 113
    .outGrabTool = 114
    SPEED 100.0 MM/S ALWAYS
    CALL homeRobot
    JMOVE #[45, 0, -15, 0, -30, 0] ; Move to good tool position
    BITS(.outRequestTool, 3) = .requestedTool
    WAIT .requestedTool == .inCurrentTool
    CALL homeRobot

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
 .END
