.PROGRAM Option4()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 0 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

    CALL CalibEstNSEge
    CALL CalibWstNSEge
    CALL CalibWstEWEge
    CALL homeRobot
    CALL changeTool(0, 4)
 .END
