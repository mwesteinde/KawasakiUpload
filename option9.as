.PROGRAM Option9()
    ; First tool is set in firstTool[] in autostart.as and sent by programcontrol.pc
    ; when this program is selected. Update it there if the first tool changes.
    ; No start wait: programcontrol.pc only runs this program after the PLC start signal
    BITS outProgRunning, 1 = 1

    ;===========Half Inch tool===================
    CALL wstcbfnttopegehf
    CALL wstcbfntedgehf
    CALL estcbtopegehf
    CALL estcbedgehf
    CALL estcbbackhf

    ;===========Blade===================
    
    CALL changeTool(4, 0)
    CALL wstcbfntedgebl
    CALL wstcbfntbackbl
    CALL estcbedgebl
    CALL changeTool(0,4)
 .END
