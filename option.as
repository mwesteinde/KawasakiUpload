.PROGRAM Option()
    ;MUST have next three lines in all programs!
    .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
    BITS outRequestTool, 3 = .firstToolIndex
    WAIT SIG(inProgramStart)

    ;Quarter Inch
    ; CALL Tstctqtr
    
    ; ;===========Half Inch tool===================
    ; CALL changeTool(2, 4, intoolAutoChange)
    ; CALL handlesbrd2 ;Glass door cut out with half inch bit
    ; CALL plyply2

    ; CALL changeTool(4, 2, intoolAutoChange)
    ; CALL plyright

    ; ;===========Blade===================
    ; CALL changeTool(4, 0, intoolAutoChange)
    ; CALL estfntthrdbl
    DELAY(5)
    PRINT("2")
    DELAY(0.5)
    PRINT("3")
    DELAY(0.5)
    PRINT("4")
    DELAY(0.5)
    PRINT("5")
    DELAY(0.5)
    PRINT("6")
    DELAY(0.5)
    PRINT("7")
    DELAY(0.5)
    PRINT("8")
    DELAY(0.5)
    PRINT("9")
    ; CALL homeRobot
 .END
