.PROGRAM pg00()
    ; Define variables
    .numberProgramFrontWall = 1
    .numberProgramBackWall = 2
    .numberOption = 3
    .numberProgramToolChange = 10
    .programBits = 4
    SPEED 100.0 MM/S ALWAYS
    BITS outProgramRunning, 1 = 0
    
    IF SIG(inProgramHome) THEN
        BITS outProgramRunning, 1 = 1
        CALL homeRobot
        BITS outProgramRunning, 1 = 0
    END
    .programRequest = BITS(inProgramChoice, .programBits)

    IF SIG(inProgramStart) THEN
        IF .programrequest == .numberProgramFrontWall THEN
            BITS outProgramRunning, 1 = 1
            CALL frontWall
            BITS outProgramRunning, 1 = 0
        END
        IF .programrequest == .numberProgramBackWall THEN
            BITS outProgramRunning, 1 = 1
            CALL backWall
            BITS outProgramRunning, 1 = 0
        END
        IF .programrequest == .numberOption THEN
            BITS outProgramRunning, 1 = 1
            CALL Option
            BITS outProgramRunning, 1 = 0
        END
        IF .programrequest == .numberProgramToolChange THEN
            BITS outProgramRunning, 1 = 1
            CALL changeTool(BITS(inCurrentTool, 3), BITS(inRequestedTool, 3), intoolAutoChange)
            BITS outProgramRunning, 1 = 0
        END
    END
.END
