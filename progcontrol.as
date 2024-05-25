.PROGRAM pg00()
    Wait(1)
    ; Define variables
    .numProgFrontWall = 1
    .numProgBackWall = 2
    .numOption3 = 3
    .numOption4 = 4
    .numOptionCbeFnt = 5
    .numOption5 = 6
    .numOption6 = 7
    .numOption7 = 8
    .numOptionCbeBck = 9
    .numProgToolChg = 10
    .numProgMoveRbt = 11
    .numProgHomeRbt = 12
    .numProgCleanRbt = 13
    .numProgToolCalb = 14
    .programBits = 4
    SPEED 100.0 MM/S ALWAYS
    BITS outProgRunning, 1 = 0
    BITS outToolUpdated, 1 = 0
    ;Read requested program
    BITS outCurrentProgram, 4 = 0 ; Current program is programcontrol
    .programRequest = BITS(inProgramChoice, .programBits)
    BREAK
    
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

        IF .programrequest == .numProgToolCalb THEN
            BITS outCurrentProgram, 4 = .numProgToolCalb
            BITS outProgRunning, 1 = 1
            CALL moveToCalibrate
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
        IF .programrequest == .numOption4 THEN
            BITS outCurrentProgram, 4 = .numOption4   
            CALL Option4
            BITS outProgRunning, 1 = 0
        END
        IF .programrequest == .numOption5 THEN
            BITS outCurrentProgram, 4 = .numOption5   
            CALL Option5
            BITS outProgRunning, 1 = 0
        END
        IF .programrequest == .numOption6 THEN
            BITS outCurrentProgram, 4 = .numOption6   
            CALL Option6
            BITS outProgRunning, 1 = 0
        END
        IF .programrequest == .numOption7 THEN
            BITS outCurrentProgram, 4 = .numOption7   
            CALL Option7
            BITS outProgRunning, 1 = 0
        END
        IF .programrequest == .numOptionCbeFnt THEN
            BITS outCurrentProgram, 4 = .numOptionCbeFnt
            CALL cubeSaunaFront
            BITS outProgRunning, 1 = 0
        END
        IF .programrequest == .numOptionCbeBck THEN
            BITS outCurrentProgram, 4 = .numOptionCbeBck
            CALL cubeSaunaBack
            BITS outProgRunning, 1 = 0
        END
    END
    
.END
