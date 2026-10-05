.PROGRAM pcrun()
    ; DRY-RUN STAND-IN FOR pcrun.as - CONTAINS NO MOTION INSTRUCTIONS.
    ; Load this file instead of pcrun.as to test programcontrol.pc and the PLC
    ; handshakes without moving the robot. It replaces pcrun on the controller,
    ; so RELOAD pcrun.as WHEN TESTING IS FINISHED.
    ;
    ; Cutting programs (1-9), Home (12) and Cleanup (13) pretend to run for
    ; .runTime seconds. Kept under 3 s so the PLC tool-coordinate check in RUN
    ; (3 s timer) does not trip while nothing is really cutting.
    ; Tool change (10) only prints: it must not touch the tool outputs, or the
    ; PLC would believe a tool change happened that did not.
    ; Manual move (11) and tool calibration (14) run until stopped, to test the
    ; PLC Stop (1041 -> MC HOLD + MC ABORT in programcontrol.pc).
    .p = pcProg
    pcProg = 0
    .runTime = 2
    PRINT "DRY RUN pcrun: program ", .p, " started at ", TIMER(0)
    IF (.p >= 1) AND (.p <= 9) THEN
        BITS outProgRunning, 1 = 1 ; as the real programs do
        PRINT "  options 1021-1023: ", SIG(1021), " ", SIG(1022), " ", SIG(1023)
        PRINT "  options 1039-1040: ", SIG(1039), " ", SIG(1040), "  board 5.1in: ", SIG(inWoodWidth51)
        TWAIT .runTime
    END
    IF .p == 10 THEN
        PRINT "  tool change ", pcCurTool, " -> ", pcReqTool, " (not performed)"
        TWAIT .runTime
    END
    IF (.p == 12) OR (.p == 13) THEN
        TWAIT .runTime
    END
    IF (.p == 11) OR (.p == 14) THEN
        PRINT "  running until the PLC stops it"
        WHILE 1 DO
            TWAIT 0.1
        END
    END
    PRINT "DRY RUN pcrun: program ", .p, " done at ", TIMER(0)
.END
