.PROGRAM pcwatch.pc()
    ; Test monitor for programcontrol.pc. Prints the PLC handshake signals,
    ; robot program state and dispatcher state every time any of them changes.
    ; Read-only: writes no signals and no variables used elsewhere.
    ;   Start:  PCEXECUTE 3: pcwatch.pc      Stop:  PCABORT 3:
    ; (PC slot 3 is free: autostart.pc aborts it at power-up and starts nothing in it.)
    FOR .i = 0 TO 16
        .old[.i] = -99
    END
    PRINT "pcwatch started at ", TIMER(0)
    WHILE 1 DO
        ; From the PLC
        .v[0] = SIG(inProgramStart)
        .v[1] = SIG(inProgSelected)
        .v[2] = BITS(inProgramChoice, 4)
        .v[3] = SIG(inPcKill)
        .v[4] = SIG(inResetProgram)
        .v[5] = SIG(inProgramHold)
        .v[6] = SIG(inTurnMotorOn)
        ; Robot state
        .v[7] = SWITCH(POWER)
        .v[8] = TASK(1)
        ; To the PLC
        .v[9] = BITS(outCurrentProgram, 4)
        .v[10] = SIG(outProgRunning)
        .v[11] = BITS(outRequestTool, 4)
        .v[12] = SIG(outToolUpdated)
        ; programcontrol.pc state
        .v[13] = pcArmed
        .v[14] = pcLaunched
        .v[15] = pcProg
        .v[16] = SIG(outinTeach)
        .chg = 0
        FOR .i = 0 TO 16
            IF .v[.i] <> .old[.i] THEN
                .chg = 1
            END
            .old[.i] = .v[.i]
        END
        IF .chg THEN
            PRINT TIMER(0), " PLC start=", .v[0], " sel=", .v[1], " choice=", .v[2], " stop=", .v[3], " reset=", .v[4], " hold=", .v[5], " motorOn=", .v[6]
            PRINT "    power=", .v[7], " task=", .v[8], " | curProg=", .v[9], " running=", .v[10], " reqTool=", .v[11], " toolUpd=", .v[12], " | armed=", .v[13], " launched=", .v[14], " pcProg=", .v[15], " teach=", .v[16]
        END
        TWAIT 0.02
    END
.END
