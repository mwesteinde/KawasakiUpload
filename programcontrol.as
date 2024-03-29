.PROGRAM progcontrol()
    ; Define variables
    .numberProgramFrontWall = 1
    .numberProgramBackWall = 2
    .programBits = 4
    outProgramRunning = 115
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
    END
.END
