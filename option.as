.PROGRAM Option()
    ;Quarter Inch
    ; CALL Tstctqtr
    
    ; ;===========Half Inch tool===================
    ; CALL changeTool(2, 4, intoolAutoChange)
    ; CALL Tstcthf

    ; ;===========Blade===================
    ; CALL changeTool(4, 0, intoolAutoChange)
    CALL EstFntGlsDrBlNS
    CALL EstFntGlsDrBlEW

    CALL homeRobot
 .END
