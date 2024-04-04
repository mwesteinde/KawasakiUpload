.PROGRAM autostart.pc()
    ;outjt1 is 1-16
    ;outjt2 is 17-32
    ;outjt3 is 33-48
    ;outjt4 is 49-64
    ;outjt5 is 65-80
    ;outjt6 is 81-96
    outMotorOn = 97 ; Dedicated output signal
    outError = 98 ; Dedicated output signal
    outAutoMode = 99 ; Dedicated output signal
    outAtHome = 100 ; Dedicated output signal
    outinTeach = 101 ; Dedicated output signal
    outCycleStart = 102 ; Dedicated output signal
    outPowerOn = 103 ; Dedicated output signal
    outPoseDataSent = 104
    outEStop = 105
    outBatteryAlarm = 106
    outCurrentTool = 107 ; 107-109
    outRequestTool = 110 ; 110-112
    outReleaseTool = 113
    outProgramRunning = 115
    
    inTurnMotorOn = 1001 ; Dedicated input signal
    inResetError = 1002 ; Dedicated input
    inStartCycle = 1003 ; Dedicated input
    inResetProgram = 1004 ; Dedicated input
    inProgramStart = 1005
    inProgramHold = 1006
    inProgramHome = 1007
    inMotorOff = 1008
    inToolReleased = 1009
    inCurrentTool = 1011 ; 1011-1013
    inEStopOff = 1014 ; Dedicated input, disabled
    intoolAutoChange = 1015 ; Should be always true
    inSpindleOn = 1016
    inProgramChoice = 1017 ; 1017-1020 TODO: Make 4 bits
    inProgramOption1 = 1021
    inProgramOption2 = 1022
    inProgramOption3 = 1023
    inRequestedTool = 1024 ; 1024-1026 TODO: Make 4 bits
    
    PCABORT 2:
    PCEXECUTE 2: posedata.pc, -1 ; Executes pose data continuously
    ; WAIT SIG(1012) ; E stop ethercat
    WAIT SWITCH(POWER)
    WAIT NOT SIG(98)
    MC EXECUTE progcontrol, -1
.END
