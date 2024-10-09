.PROGRAM Option4()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1

    CALL EstFntDiscHf ;Cut out disc both sides
    CALL estfntdischftop
    CALL estfntwngmrkhf
    CALL estfntdischfbot
    CALL EstFntWdDrHf;Wood door cut out with half inch bit
    CALL EstFntWdDrHfLst

    CALL changeTool(4, 0)
    CALL EstFntWdDrBlNS
    CALL EstFntWdDrBlEW
    CALL homeRobot
    CALL changeTool(0, 4)
 .END
