.PROGRAM autostart.pc()
    PCABORT 2:
    PCEXECUTE 2: posedata.pc, -1 ; Executes pose data continuously
    WAIT SWITCH(POWER)
    MC EXECUTE progcontrol, -1
.END
