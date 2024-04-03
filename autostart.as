.PROGRAM autostart.pc()
    inToolReleased = 1009
    inMotorOff = 1008
    inSpindleOn = 1016
    outCurrentTool = 107
    outRequestTool = 110
    outReleaseTool = 113
    outProgramRunning = 115
    inCurrentTool = 1011
    inRequestedTool = 1024
    intoolAutoChange = 1015
    inProgramStart = 1005
    inProgramHold = 1006
    inProgramHome = 1007
    inProgramChoice = 1017
    PCABORT 2:
    PCEXECUTE 2: posedata.pc, -1 ; Executes pose data continuously
    ; WAIT SIG(1012) ; E stop ethercat
    WAIT SWITCH(POWER)
    WAIT NOT SIG(98)
    MC EXECUTE progcontrol, -1
.END
