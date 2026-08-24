.PROGRAM Option6()
    inOptBothWings = inProgOption2
    inOptEastWing = inProgOption1

    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

    IF BITS(inOptBothWings, 1) THEN
        IF BITS(inWoodWidth51,1) THEN
            CALL Wings5_1wst
            CALL Wings5_1est
        ELSE
            CALL Wings4_75wst
            CALL Wings4_75est
        END
    ELSE
        IF BITS(inOptEastWing, 1) THEN
            IF BITS(inWoodWidth51,1) THEN
                CALL Wings5_1est
            ELSE
                CALL Wings4_75est
            END
        ELSE
            IF BITS(inWoodWidth51,1) THEN
                CALL Wings5_1wst
            ELSE
                CALL Wings4_75wst
            END
        END
    END
    CALL homeRobot

 .END
