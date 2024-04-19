.PROGRAM Option()
    ;Quarter Inch
    ; CALL Tstctqtr
    
    ; ;===========Half Inch tool===================
    ; CALL changeTool(2, 4, intoolAutoChange)
    CALL estfntthrdhf ;Glass door cut out with half inch bit

    ; ;===========Blade===================
    CALL changeTool(4, 0, intoolAutoChange)
    CALL estfntthrdbl

    CALL homeRobot
 .END
