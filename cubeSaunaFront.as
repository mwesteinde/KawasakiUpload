.PROGRAM cubesaunafront()
    inOptRearWall = 1021
    inOptGlassDoor = 1022
    inProgOption3 = 1023
    ; First tool is set in firstTool[] in autostart.as and sent by programcontrol.pc
    ; when this program is selected. Update it there if the first tool changes.
    ; No start wait: programcontrol.pc only runs this program after the PLC start signal
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
            BITS outFinalToolChange, 1 = 1 ; Last tool change, nothing is cut after it: the PLC does not hold for Tool Loaded
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
            BITS outFinalToolChange, 1 = 1 ; Last tool change, nothing is cut after it: the PLC does not hold for Tool Loaded
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
            BITS outFinalToolChange, 1 = 1 ; Last tool change, nothing is cut after it: the PLC does not hold for Tool Loaded
            CALL changeTool(0,4)
        END
    END
 .END
