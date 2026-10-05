.PROGRAM pcrun()
    ; Started only by programcontrol.pc with MC EXECUTE pcrun, 1. Runs the
    ; program that programcontrol.pc put in pcProg. pcProg is cleared first, so a
    ; stray cycle start that re-runs pcrun from step 1 finds nothing to run.
    .p = pcProg
    pcProg = 0
    SPEED 100.0 MM/S ALWAYS
    IF .p == 1 THEN
        CALL frontWall
    END
    IF .p == 2 THEN
        CALL backWall
    END
    IF .p == 3 THEN
        CALL Option3
    END
    IF .p == 4 THEN
        CALL Option4
    END
    IF .p == 5 THEN
        CALL cubeSaunaFront
    END
    IF .p == 6 THEN
        CALL Option5
    END
    IF .p == 7 THEN
        CALL Option6
    END
    IF .p == 8 THEN
        CALL Option7
    END
    IF .p == 9 THEN
        CALL Option9
    END
    IF .p == 10 THEN
        CALL changeTool(pcCurTool, pcReqTool)
    END
    IF .p == 11 THEN
        CALL manualmoverobot
    END
    IF .p == 12 THEN
        CALL homeRobot
    END
    IF .p == 13 THEN
        CALL cleanupPose
    END
    IF .p == 14 THEN
        CALL moveToCalibrate
    END
.END
