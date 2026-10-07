.PROGRAM programcontrol.pc()
    ; Robot program dispatcher. Runs continuously as PC program 4
    ; (PCEXECUTE 4: programcontrol.pc, -1 in autostart.pc). Replaces pg00.
    ;
    ; The PLC selects a program with inProgramChoice + inProgSelected and starts
    ; it with a rising edge on inProgramStart. This program then runs it with
    ; MC EXECUTE pcrun, and pcrun CALLs the selected program. PC programs cannot
    ; move the robot or set TOOL, so all motion stays in pcrun and its callees.
    ;
    ; Outputs owned here: outCurrentProgram, outProgRunning, outToolUpdated,
    ; outPcHeartbeat, outFinalToolChange (cleared here, set by the cutting programs),
    ; and outRequestTool while no robot program is running
    ; (changeTool writes outRequestTool during a run).
    ;
    ; Globals are initialised and described in autostart.pc.

    ; Heartbeat: the PLC treats 1 s without a change as "dispatcher not running".
    ; Every wait loop below toggles it too.
    pcBeat = 1 - pcBeat
    BITS outPcHeartbeat, 1 = pcBeat

    ; TASK(1): 0 idle, 1 running, 2 held, 3 finishing its last motion
    .task = TASK(1)

    ; PLC stop request (1041). The PLC keeps it on until outProgRunning drops, so
    ; it is acted on as a level: hold, abort, and repeat until the program is gone.
    IF SIG(inPcKill) AND (.task <> 0) THEN
        IF (.task == 1) OR (.task == 3) THEN
            MC HOLD
            .n = 0
            WHILE (TASK(1) <> 2) AND (TASK(1) <> 0) AND (.n < 40) DO
                TWAIT 0.05
                .n = .n + 1
                pcBeat = 1 - pcBeat
                BITS outPcHeartbeat, 1 = pcBeat
            END
        END
        IF TASK(1) <> 0 THEN
            MC ABORT
            .n = 0
            WHILE (TASK(1) <> 0) AND (.n < 20) DO
                TWAIT 0.05
                .n = .n + 1
                pcBeat = 1 - pcBeat
                BITS outPcHeartbeat, 1 = pcBeat
            END
        END
        .task = TASK(1)
    END

    ; Latch a start together with the program it was made for. A start that is
    ; already on when a program gets selected does not count.
    IF SIG(inProgramStart) AND NOT pcStartPrev THEN
        pcArmed = BITS(inProgramChoice, 4)
        pcRetryAt = 0
    END
    IF NOT SIG(inProgramStart) THEN
        pcArmed = 0
    END
    pcStartPrev = SIG(inProgramStart)

    IF .task <> 0 THEN
        ; outProgRunning stays on until the program is really gone, including after
        ; a stop, so the PLC never sees an idle robot while a program is loaded
        IF pcLaunched THEN
            BITS outProgRunning, 1 = 1
        END
    ELSE
        IF pcLaunched THEN
            ; The program started here has finished or been aborted
            pcLaunched = 0
            pcToolSent = 0
        END
        BITS outProgRunning, 1 = 0
        BITS outFinalToolChange, 1 = 0
        .req = BITS(inProgramChoice, 4)
        IF SIG(inProgSelected) AND (.req >= 1) AND (.req <= 14) THEN
            BITS outCurrentProgram, 4 = .req
            ; Send the first tool once per selection; the PLC checks it against
            ; the spindle tool before it allows a start
            IF (.req <= 9) AND (pcToolSent <> .req) THEN
                BITS outRequestTool, 4 = firstTool[.req]
                BITS outToolUpdated, 1 = 1
                TWAIT 0.2
                BITS outToolUpdated, 1 = 0
                pcToolSent = .req
            END
            ; Launch only when the PLC has released the hold (inProgramHold on = run),
            ; motor power is on, the robot is not in TEACH, no stop is requested, and
            ; any retry delay has passed
            .ok = (pcArmed == .req) AND SWITCH(POWER) AND SIG(inProgramHold)
            .ok = .ok AND NOT SIG(outinTeach) AND NOT SIG(inPcKill) AND (TIMER(0) >= pcRetryAt)
            IF .ok THEN
                pcCurTool = BITS(inCurrentTool, 4)
                pcReqTool = BITS(inRequestedTool, 4)
                pcProg = .req
                MC EXECUTE pcrun, 1
                ; pcrun clears pcProg as its first step, which confirms it started
                .n = 0
                WHILE (pcProg <> 0) AND (.n < 20) DO
                    TWAIT 0.05
                    .n = .n + 1
                    pcBeat = 1 - pcBeat
                    BITS outPcHeartbeat, 1 = pcBeat
                END
                IF pcProg == 0 THEN
                    pcArmed = 0
                    pcLaunched = 1
                    BITS outProgRunning, 1 = 1
                ELSE
                    ; Did not start. Retry in 1 s while the PLC still requests it;
                    ; the PLC start timeout ends the request after 30 s.
                    pcProg = 0
                    pcRetryAt = TIMER(0) + 1
                END
            END
        ELSE
            BITS outCurrentProgram, 4 = 0
            pcToolSent = 0
        END
    END
    TWAIT 0.02
.END
