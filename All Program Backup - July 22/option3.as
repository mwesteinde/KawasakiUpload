.PROGRAM Option3()
    inOptRearWall = inProgOption1
;MUST have next three lines in all programs!
    .firstToolIndex = 0 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

   
    IF -BITS(inOptRearWall, 1) THEN
        CALL wstcbfntedgebl
        CALL wstcbfntbackbl
        CALL estcbedgebl
        CALL changeTool(0,4)
    ELSE
        CALL wstcbfntedgebl
        CALL wstcbfntdoorblns
        CALL wstcbfnthndlsbl
        CALL wstcbfntdoorblew
        CALL wstcbfntbackbl
        CALL estcbedgebl
        CALL changeTool(0,4)
    END
.END
