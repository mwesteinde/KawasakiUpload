.PROGRAM progcontrol()
    ; Define variables
    .numberProgramFrontWall = 1
    .numberProgramBackWall = 2
    .inProgramStart = 1005
    .inProgramHold = 1006
    .inProgramHome = 1007
    .programChoice = 1017
    .programBits = 4
    .outProgramRunning = 115
    BITS .outProgramRunning, 1 = 0
    IF SIG(.inProgramHome) THEN
        BITS .outProgramRunning, 1 = 1
        CALL homeRobot
        BITS .outProgramRunning, 1 = 0
    END
    .programRequest = BITS(.programChoice, .programBits)

    IF SIG(.inProgramStart) THEN
        IF .programrequest == .numberProgramFrontWall THEN
            BITS .outProgramRunning, 1 = 1
            CALL frontWall
            BITS .outProgramRunning, 1 = 0
        END
        IF .programrequest == .numberProgramBackWall THEN
            BITS .outProgramRunning, 1 = 1
            CALL backWall
            BITS .outProgramRunning, 1 = 0
        END
    END
    DELAY 5
.END
