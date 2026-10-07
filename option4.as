.PROGRAM Option4()

    ; First tool is set in firstTool[] in autostart.as and sent by programcontrol.pc
    ; when this program is selected. Update it there if the first tool changes.
    ; No start wait: programcontrol.pc only runs this program after the PLC start signal
    BITS outProgRunning, 1 = 1

    CALL cubewndwhf
    CALL changeTool(4, 0)
    CALL cubewndwNSbl
    CALL homeRobot
    CALL changeTool(0, 4)


 .END
