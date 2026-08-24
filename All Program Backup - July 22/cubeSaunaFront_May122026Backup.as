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

        CALL changeTool(4,0)

        ;===========Blade===================
        IF BITS(inOptRearWall, 1) THEN
        PRINT "Blade Only and Rear wall"
            CALL wstcbfntedgebl
            ;CALL wstcbfntbackbl - No longer used since it can't reach here easily (updated by Kris, April 21 2026 when we went to 3" wider cube). Uses backhf instead
            CALL estcbedgebl
            CALL changeTool(0,4)
        ELSE
        PRINT "Blade Only and Front wall"
            CALL changeTool(4, 0)
            CALL wstcbfntedgebl
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door Blade"

                CALL wstcbfntgldrblNS
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

                CALL wstcbfntgldrblew

            ELSE
            PRINT "Front Wall - STD Door Blade EW"
                IF BITS(inWoodWidth51,1) THEN
                CALL wstcbfntdoorblew
                ELSE
                CALL wstcbf49doorblew
                END
            END
            ; CALL wstcbfntbackbl - deprecated by Kris April 21 2026, robot couldn't reach
            CALL estcbedgebl
            CALL changeTool(0,4)
        END
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
           ; CALL wstcbfntbackbl -deprecated by Kris on April 21 2026
            CALL estcbedgebl
            CALL changeTool(0,4)
        ELSE
        PRINT "Front Wall Selected"

            CALL wstcbfnttopegehf
            ;CALL wstcbfnthndlshf
            ;===========Half Inch tool===================
            
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
            ;CALL wstcbfntbackbl -deprecated by Kris on April 21 2026
            CALL estcbedgebl
            CALL changeTool(0,4)
        END
    END
 .END
