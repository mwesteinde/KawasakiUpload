.PROGRAM changeTool(.currentTool, .requestedTool)
    BITS outRequestTool,4 = .requestedTool 
    TOOL TRANS(74.135, 193.39, 512.99, 89.944, 45.018, 1.472)
    BASE TRANS(0.0000,0.0000,0.000,0.0000,0.0000,0.0000)
;     0: Sawblade
;     1: 
;     2: Quarter Inch
;     3: 
;     4: Half inch
;     5: 
;       8: no tool
;   Defined
;   toolpose[0-8]
;   changeToolHome
    PRINT .currentTool
    PRINT .requestedTool

    POINT .approach = TRANS(100, 0, 0, 0, 0, 0)
    POINT .retract = TRANS(0, 0, -100, 0, 0, 0)

    IF .currentTool <> .requestedTool THEN
        CALL homeRobot600 ; Changes speed to 600
        ;Automatic tool change
        ;Drop off tool
        JMOVE changeToolHome + TRANS(0, 0, -300, 0, 0, 0)
        JMOVE changeToolHome
        SPEED 400.0 MM/S ALWAYS
        WAIT BITS(inSpindleOff, 1)
        FOR index=0 TO 6 ;TODO: Test 0-7 tools
            IF .currentTool == index THEN
                JMOVE toolpose[index] + .approach
                SPEED 20 MM/s ALWAYS
                LMOVE toolpose[index]
                BITS outReleaseTool, 1 = 1
                WAIT SIG(inToolReleased)
                LMOVE toolpose[index] + .retract
                BITS outReleaseTool, 1 = 0
            END
        END
        ;Pick up tool
        FOR index=0 TO 6
            IF .requestedTool == index THEN
                SPEED 400.0 MM/S ALWAYS
                JMOVE toolpose[index] + .retract
                BITS outReleaseTool, 1 = 1
                WAIT SIG(inToolReleased)
                SPEED 20.0 MM/S ALWAYS
                LMOVE toolpose[index]
                BITS outReleaseTool, 1 = 0
                WAIT NOT SIG(inToolReleased)
                LMOVE toolpose[index] + .approach
                BITS outReleaseTool, 1 = 0
            END
        END
        SPEED 400 MM/S ALWAYS
        JMOVE changeToolHome
        SPEED 600 MM/S ALWAYS
        CALL homeRobot600
    END
    BITS outCurrentTool, 4 = .requestedTool
    PRINT .requestedTool
    DELAY(0.1)
 .END

.PROGRAM homeRobot600()
    rollerHeight = 800
    BASE TRANS(0.0000,0.0000,0.000,0.0000,0.0000,0.0000)
    ACCURACY 1.000 ALWAYS
    SPEED 600.0 MM/S ALWAYS
    PRINT "HOME"
    DECOMPOSE currentPose[0] = HERE
    IF currentPose[2] < rollerHeight THEN
        LMOVE SHIFT(HERE BY 0,0,rollerHeight-currentPose[2])
        JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
    ELSE
        JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
    END
    PRINT "DONE"
    BASE NULL
.END
