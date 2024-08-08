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
    outCurrentTool = 107 ; 107-110 //CHANGED
    outRequestTool = 111 ; 111-114 //CHANGED
    outReleaseTool = 115 ;//CHANGEd
    outProgRunning = 116 ;//CHANGEd
    outToolUpdated = 117
    outStartofProgram = 118
    outCurrentProgram = 119 ;119-122
    outAtClean = 123 ; Dedicated output
    ;outzpose is 129-144
    ;outtoolx is 145-156
    ;outtooly is 157-168
    ;outtoolz is 169-180
    
    inTurnMotorOn = 1001 ; Dedicated input signal
    inResetError = 1002 ; Dedicated input
    inStartCycle = 1003 ; Dedicated input
    inResetProgram = 1004 ; Dedicated input
    inProgramStart = 1005
    inProgramHold = 1006
    inProgramHome = 1007
    inMotorOff = 1008
    inToolReleased = 1009
    inCurrentTool = 1010 ; 1010-1013
    inEStopOff = 1014 ; Dedicated input
    inSpindleOff = 1016
    inProgramChoice = 1017 ;1017-1020
    inProgOption1 = 1021
    inProgOption2 = 1022
    inProgOption3 = 1023
    inRequestedTool = 1024 ; 1024-1027
    inProgSelected = 1028 ;Flag for when program is selected
    inProgramClean = 1029
    inxmove = 1030
    inymove = 1031
    inzmove = 1032
    inmovepositive = 1033
    inWoodWidth51 = 1034 ;1 if wood width is 5.1inches, 0 if wood width is 4.75in
    inManMoveDstnce = 1035 ; 1035-1037 inManualMoveDistance
    inDustBootUp = 1038
    inProgOption4 = 1039
    
    PCABORT 2:
    PCABORT 3:
    PCEXECUTE 2: posedata.pc, -1 ; Executes pose data continuously
    WAIT SIG(inEStopOff) ; E stop ethercat
    WAIT SWITCH(POWER)
    WAIT NOT SIG(outError)
    MC EXECUTE pg00, -1
.END
