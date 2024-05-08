.PROGRAM pg00()
    ; Define variables
    .numberProgramFrontWall = 1
    .numberProgramBackWall = 2
    .numberOption = 3
    .numberProgramToolChange = 10
    .programBits = 4
    SPEED 100.0 MM/S ALWAYS
    BITS outProgramRunning, 1 = 0
    BITS outToolUpdated, 1 = 0

    ;Read requested program
    .programRequest = BITS(inProgramChoice, .programBits)
    
    IF SIG(inProgramHome) THEN
        BITS outProgramRunning, 1 = 1
        CALL homeRobot
        BITS outProgramRunning, 1 = 0
    END

    IF SIG(inProgramStart) THEN
        IF .programrequest == .numberProgramToolChange THEN
            BITS outProgramRunning, 1 = 1
            CALL changeTool(BITS(inCurrentTool, 4), BITS(inRequestedTool, 4))
            BITS outProgramRunning, 1 = 0
        END
    END
    IF SIG(inProgramSelected) THEN
        IF .programrequest == .numberProgramFrontWall THEN
            CALL frontWall
            BITS outProgramRunning, 1 = 0
        END
        IF .programrequest == .numberProgramBackWall THEN
            CALL backWall
            BITS outProgramRunning, 1 = 0
        END
        IF .programrequest == .numberOption THEN
            CALL Option
            BITS outProgramRunning, 1 = 0
        END
    END
    
.END
