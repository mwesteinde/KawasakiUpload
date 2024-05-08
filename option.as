.PROGRAM Option()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 4 = .firstToolIndex
    BITS outToolUpdated, 1 = 1
    WAIT SIG(inProgramStart)
    BITS outToolUpdated, 1 = 0
    BITS outProgramRunning, 1 = 1
    TOOL TRANS(0.292,133.845,454.558,90.0007,44.9998,-0.0010)
    JMOVE #[5, 0, -15, 0, -30, 0] ; Move to home
    JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
    CALL changeTool(4,0)
     ACCURACY 1.000 ALWAYS
    TYPE "/'WstBckChimyHf'"
    TYPE "/''"
    TYPE "/'ChimyHf'"
    SPEED 300.0 MM/S ALWAYS
    TOOL TRANS(74,192.463,508.959,89.9440,45.0180,1.4720)
    JMOVE #[5, 0, -15, 0, -30, 0] ; Move to home
    JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
 .END
