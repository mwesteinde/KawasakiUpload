.PROGRAM cubesaunafront()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

    ;===========Half Inch tool===================
    CALL wstcbfntdoorhf
    CALL wstcbfnttopegehf
    CALL wstcbfntedgehf
    CALL wstcbfnthndlshf
    CALL estcbtopegehf
    CALL estcbedgehf

    ;===========Blade===================
    
    CALL changeTool(4, 0)
    CALL wstcbfntedgebl
    CALL wstcbfntdoorblns
    CALL wstcbfntdoorblew
    CALL wstcbfnthndlsbl
    CALL estcbedgebl
    CALL changeTool(0,4)
 .END
