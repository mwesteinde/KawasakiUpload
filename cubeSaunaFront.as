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
            CALL wstcbfntbackbl
            CALL estcbedgebl
            CALL changeTool(0,4)
        ELSE
        PRINT "Blade Only and Front wall"

            CALL wstcbfntedgebl
            CALL wstcbfntdoorblns
            ;CALL wstcbfnthndlsbl
            CALL wstcbfntdoorblew
            CALL wstcbfntbackbl
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

        ;===========Blade===================
        
            CALL changeTool(4, 0)
            CALL wstcbfntedgebl
            CALL wstcbfntbackbl
            CALL estcbedgebl
            CALL changeTool(0,4)
        ELSE
        PRINT "Front Wall Selected"

            CALL wstcbfnttopegehf
            ;CALL wstcbfnthndlshf
            ;===========Half Inch tool===================
            
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door"

                CALL wstcbfntglsdrhf
            ELSE
                CALL wstcbfntdoorhf
            PRINT "Front Wall - Glass Door"
            END
            CALL wstcbfntedgehf
            CALL estcbtopegehf
            CALL estcbedgehf
            CALL estcbbackhf


            ;===========Blade===================

            CALL changeTool(4, 0)
            CALL wstcbfntedgebl
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door Blade"

                CALL wstcbfntgldrblNS
            ELSE
            PRINT "Front Wall - STD Door Blade"

                CALL wstcbfntdoorblns
            END
            ;CALL wstcbfnthndlsbl
            IF BITS(inOptGlassDoor, 1) THEN
            PRINT "Front Wall - Glass Door Blade EW"

                CALL wstcbfntgldrblew

            ELSE
            PRINT "Front Wall - STD Door Blade EW"

                CALL wstcbfntdoorblew
            END
            CALL wstcbfntbackbl
            CALL estcbedgebl
            CALL changeTool(0,4)
        END
    END
 .END
