.PROGRAM Option7()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

    CALL handlessevenhf
    CALL changeTool(4,0)
    CALL handlessevenbl
    CALL homeRobot
    CALL changeTool(0, 4)
 .END
