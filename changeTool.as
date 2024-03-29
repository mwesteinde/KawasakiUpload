;0: Quarter inch
;1: Half Inch
;2: Sawblade
;3: Dovetail
;4: Half inch ball
;5: Quarter inch ball

.PROGRAM changeTool(.currentTool, .requestedTool, .isAuto)
    SPEED 100.0 MM/S ALWAYS
    POINT .approach = TRANS(0,-300, 0, 0, 0, 0)
    POINT .retract = TRANS(0, 0, -300, 0, 0, 0)
    ;To define
    ;toolpose[0-8]
    ;changeToolHome
    BITS(outRequestTool,3) = requestedTool 

    CALL homeRobot
    
    IF isAuto THEN
    ;Automatic tool change
        ;Drop off tool
        JMOVE changeToolHome
        WAIT NOT BITS(inSpindleOn, 1)
        FOR index=0 TO 8
            IF .currentTool == index THEN
                JMOVE toolpose[index] + .approach
                LMOVE toolpose[index]
                BITS(outReleaseTool, 1) = 1
                WAIT inToolReleased
                LMOVE toolpose[index] + .retract
                BITS(outReleaseTool, 1) = 0
            END
        END
        ;Pick up tool
        FOR index=0 TO 8
            IF .requestedTool == index THEN
                JMOVE toolpose[index] + .retract
                BITS(outReleaseTool, 1) = 1
                WAIT inToolReleased
                LMOVE toolpose[index]
                BITS(outReleaseTool, 1) = 0
                WAIT NOT inToolReleased
                LMOVE toolpose[index] + .approach
                BITS(outReleaseTool, 1) = 0
            END
        END
    
    ELSE
    ;Manual tool change
        JMOVE #[45, 0, -15, 0, -30, 0] ; Move to good tool position
        BITS(outRequestTool, 3) = .requestedTool
        BITS(outReleaseTool, 1) = 1
        WAIT .requestedTool == inCurrentTool
        BITS(outReleaseTool, 1) = 0
    END
    JMOVE changeToolHome
    CALL homeRobot
    BITS(outCurrentTool, 3) = .requestedTool
 .END
