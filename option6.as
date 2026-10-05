.PROGRAM Option6()
    inOptBothWings = inProgOption2
    inOptEastWing = inProgOption1

    ; First tool is set in firstTool[] in autostart.as and sent by programcontrol.pc
    ; when this program is selected. Update it there if the first tool changes.
    ; No start wait: programcontrol.pc only runs this program after the PLC start signal
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
