.PROGRAM changeTool(.currentTool, .requestedTool, .isAuto)
    SPEED 500.0 MM/S ALWAYS
    TOOL TRANS(-1.572,133.945,455.303,90.0000,45.0000,0.0000)
    BASE TRANS(0.0000,0.0000,0.000,0.0000,0.0000,0.0000)
;     0: Quarter inch
;     1: Half Inch
;     2: Sawblade
;     3: Dovetail
;     4: Half inch ball
;     5: Quarter inch ball
    PRINT .currentTool
    PRINT .requestedTool

    POINT .approach = TRANS(100, 0, 0, 0, 0, 0)
    POINT .retract = TRANS(0, 0, -100, 0, 0, 0)
    ; To define
    ; toolpose[0-8]
    ; changeToolHome
    BITS outRequestTool,3 = .requestedTool 
    IF .currentTool <> .requestedTool THEN
        CALL homeRobot
        IF .isAuto THEN
        ;Automatic tool change
            ;Drop off tool
            JMOVE changeToolHome + TRANS(0, 0, -300, 0, 0, 0)
            JMOVE changeToolHome
            SPEED 400.0 MM/S ALWAYS
            WAIT NOT BITS(inSpindleOn, 1)
            FOR index=0 TO 6
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
                    SPEED 200.0 MM/S ALWAYS
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
        ELSE
        ;Manual tool change
            JMOVE #[45, 0, -15, 0, -30, 0] ; Move to good tool position
            BITS outRequestTool, 3 = .requestedTool
            BITS outReleaseTool, 1 = 1
            WAIT .requestedTool == inCurrentTool
            BITS outReleaseTool, 1 = 0
        END
        SPEED 200 MM/S ALWAYS
        JMOVE changeToolHome
        CALL homeRobot
        BITS outCurrentTool, 3 = .requestedTool
    END
 .END
