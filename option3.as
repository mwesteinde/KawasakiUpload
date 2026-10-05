.PROGRAM Option3()
    inOptRearWall = inProgOption1
    ; First tool is set in firstTool[] in autostart.as and sent by programcontrol.pc
    ; when this program is selected. Update it there if the first tool changes.
    ; No start wait: programcontrol.pc only runs this program after the PLC start signal
    BITS outProgRunning, 1 = 1

   
    IF -BITS(inOptRearWall, 1) THEN
        CALL wstcbfntedgebl
        CALL wstcbfntbackbl
        CALL estcbedgebl
        CALL changeTool(0,4)
    ELSE
        CALL wstcbfntedgebl
        CALL wstcbfntdoorblns
        CALL wstcbfnthndlsbl
        CALL wstcbfntdoorblew
        CALL wstcbfntbackbl
        CALL estcbedgebl
        CALL changeTool(0,4)
    END
.END
