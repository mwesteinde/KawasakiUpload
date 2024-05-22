.PROGRAM pg00()
    Wait(1)
    ; Define variables
    .numProgFrontWall = 1
    .numProgBackWall = 2
    .numOption3 = 3
    .numProgToolChg = 10
    .numProgMoveRbt = 11
    .numProgHomeRbt = 12
    .numProgCleanRbt = 13
    .programBits = 4
    SPEED 100.0 MM/S ALWAYS
    BITS outProgRunning, 1 = 0
    BITS outToolUpdated, 1 = 0
    ;Read requested program
    BITS outCurrentProgram, 4 = 0 ; Current program is programcontrol
    .programRequest = BITS(inProgramChoice, .programBits)
    
    ; IF SIG(inProgramHome) THEN
    ;     BITS outProgRunning, 1 = 1
    ;     CALL homeRobot
    ;     BITS outProgRunning, 1 = 0
    ; END

    ; IF SIG(inProgramClean) THEN
    ;     BITS outProgRunning, 1 = 1
    ;     CALL cleanupPose
    ;     BITS outProgRunning, 1 = 0
    ; END

    IF SIG(inProgramStart) THEN
        IF .programrequest == .numProgToolChg THEN
            BITS outCurrentProgram, 4 = .numProgToolChg
            BITS outProgRunning, 1 = 1
            CALL changeTool(BITS(inCurrentTool, 4), BITS(inRequestedTool, 4))
            BITS outProgRunning, 1 = 0
        END

        IF .programrequest == .numProgMoveRbt THEN
            BITS outCurrentProgram, 4 = .numProgMoveRbt
            BITS outProgRunning, 1 = 1
            CALL manualmoverobot
            BITS outProgRunning, 1 = 0
        END

        IF .programrequest == .numProgHomeRbt THEN
            BITS outCurrentProgram, 4 = .numProgHomeRbt
            BITS outProgRunning, 1 = 1
            CALL homeRobot
            BITS outProgRunning, 1 = 0
        END

        IF .programrequest == .numProgCleanRbt THEN
            BITS outCurrentProgram, 4 = .numProgCleanRbt
            BITS outProgRunning, 1 = 1
            CALL cleanupPose
            BITS outProgRunning, 1 = 0
        END
    END
    
    IF SIG(inProgSelected) THEN
        IF .programrequest == .numProgFrontWall THEN
            BITS outCurrentProgram, 4 = .numProgFrontWall
            CALL frontWall
            BITS outProgRunning, 1 = 0
        END
        IF .programrequest == .numProgBackWall THEN
            BITS outCurrentProgram, 4 = .numProgBackWall
            CALL backWall
            BITS outProgRunning, 1 = 0
        END
        IF .programrequest == .numOption3 THEN
            BITS outCurrentProgram, 4 = .numOption3   
            CALL Option3
            BITS outProgRunning, 1 = 0
        END
    END
    
.END
