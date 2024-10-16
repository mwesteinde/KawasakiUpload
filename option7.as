.PROGRAM Option7()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 0 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgRunning, 1 = 1



    CALL WstFntGlsDrBlEW ;Glass door cut out with blade
    CALL WstFntGlsDrBlNS ;Glass door cut out with blade
    
     CALL EstFntGlsDrBlNS ;Glass door cut out with blade
     CALL EstFntGlsDrBlEW ;Glass door cut out with blade


    CALL homeRobot
    CALL changeTool(0, 4)
 .END
