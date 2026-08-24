.PROGRAM cubesaunafront()
    inOptRearWall = 1021
    inOptGlassDoor = 1022
    inProgOption3 = 1023
    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

    PRINT "InOptRearWall:"
    PRINT SIG(inOptRearWall)
    PRINT "inOptGlassDoor:"
    PRINT SIG(inOptGlassDoor)
    PRINT "inProgOption3:"
    PRINT SIG(inProgOption3)

    IF BITS(inProgOption3, 1) THEN
        ;change to blade for blade only option
        PRINT "Blade Only"

        ;===========Blade===================
            CALL changeTool(4, 0)
            CALL wstcbfntedgebl
            
            IF BITS(inOptRearWall, 0) THEN
            
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door Blade"

                CALL wstcbf49gldrblNS
            ELSE
            PRINT "Front Wall - STD Door Blade"

                IF BITS(inWoodWidth51,1) THEN
                CALL wstcbfntdoorblns
                ELSE
                CALL wstcbf49doorblns
                END
            END
           
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door Blade EW"

                CALL wstcbf49gldrblew

            ELSE
            PRINT "Front Wall - STD Door Blade EW"
                IF BITS(inWoodWidth51,1) THEN
                CALL wstcbfntdoorblew
                ELSE
                CALL wstcbf49doorblew
                END
            END
            END
            CALL estcbedgebl
            CALL changeTool(0,4)
    ELSE
        PRINT "Half inch and blade (entire program)"
        IF BITS(inOptRearWall, 1) THEN
        PRINT "Rear Wall Selected"

        ;===========Half Inch tool===================
            CALL wstcbfnttopegehf
            CALL wstcbfntedgehf
            CALL estcbtopegehf
            CALL estcbedgehf
            CALL estcbbackhf
            CALL wstcbfntbackhf

        ;===========Blade===================
        
            CALL changeTool(4, 0)
            CALL wstcbfntedgebl
            CALL estcbedgebl
            CALL changeTool(0,4)
        ELSE
        PRINT "Front Wall Selected"
        
            ;===========Half Inch tool===================

            CALL wstcbfnttopegehf
            
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door"
                CALL wstcbf49glsdrhf
                CALL wstcbf49ecuthf
            ELSE
                IF BITS(inWoodWidth51,1) THEN
                CALL wstcbfntdoorhf
                ELSE
                CALL wstcbf49doorhf
                CALL wstcbf49ecuthf
                END
         
            PRINT "Front Wall - Glass Door"
            END
            CALL wstcbfntedgehf
            CALL estcbtopegehf
            CALL estcbedgehf
            CALL estcbbackhf
            CALL wstcbfntbackhf



            ;===========Blade===================

            CALL changeTool(4, 0)
            CALL wstcbfntedgebl
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door Blade"

                CALL wstcbf49gldrblNS
            ELSE
            PRINT "Front Wall - STD Door Blade"

                IF BITS(inWoodWidth51,1) THEN
                CALL wstcbfntdoorblns
                ELSE
                CALL wstcbf49doorblns
                END
            END
            ;CALL wstcbfnthndlsbl
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door Blade EW"

                CALL wstcbf49gldrblew

            ELSE
            PRINT "Front Wall - STD Door Blade EW"
                IF BITS(inWoodWidth51,1) THEN
                CALL wstcbfntdoorblew
                ELSE
                CALL wstcbf49doorblew
                END
            END
            CALL estcbedgebl
            CALL changeTool(0,4)
        END
    END
 .END
