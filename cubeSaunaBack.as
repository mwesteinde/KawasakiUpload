.PROGRAM option9()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

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
 .END
