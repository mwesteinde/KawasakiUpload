.PROGRAM changeTool(.currentTool, .requestedTool)
    .inToolReleased = 1008
    .inToolGrabbed = 1009
    .inCurrentTool = 1010
    .outCurrentTool = 107
    .outRequestTool = 110
    .outReleaseTool = 113
    .outGrabTool = 114
    SPEED 100.0 MM/S ALWAYS
    CALL homeRobot
    JMOVE #[45, 0, -15, 0, -30, 0] ; Move to good tool position
    BITS(.outRequestTool, 3) = .requestedTool
    BITS(.outReleaseTool, 1) = 1
    WAIT .requestedTool == .inCurrentTool
    BITS(.outGrabTool, 1) = 1
    CALL homeRobot
 .END
