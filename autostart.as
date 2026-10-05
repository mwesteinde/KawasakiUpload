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
    outPcHeartbeat = 124 ; programcontrol.pc heartbeat, toggled every pass (PLC watchdog)
    ;outzpose is 129-144
    ;outtoolx is 145-156
    ;outtooly is 157-168
    ;outtoolz is 169-180
    
    inTurnMotorOn = 1001 ; Dedicated input signal, set from controller
    inResetError = 1002 ; Dedicated input
    inStartCycle = 1003 ; Dedicated input
    inResetProgram = 1004 ; Dedicated input
    inProgramStart = 1005
    inProgramHold = 1006
    inProgramHome = 1007
    inMotorOff = 1008
    inToolReleased = 1009
    inCurrentTool = 1010 ; 1010-1013. 
    inEStopOff = 1014 ; Dedicated input
    inSpindleOff = 1016 ; 1 if spindle is stopped
    inProgramChoice = 1017 ;1017-1020
    inProgOption1 = 1021
    inProgOption2 = 1022
    inProgOption3 = 1023
    inRequestedTool = 1024 ; 1024-1027
    inProgSelected = 1028 ; Flag for when program is selected
    inProgramClean = 1029 ; Unused
    inxmove = 1030 ; Manual movement in x
    inymove = 1031 ; Manual movement in y
    inzmove = 1032 ; Manual movement in z
    inmovepositive = 1033 ; 1 to move in positive direction, 0 otherwise
    inWoodWidth51 = 1034 ;1 if wood width is 5.1inches, 0 if wood width is 4.75in
    inManMoveDstnce = 1035 ; 1035-1037 inManualMoveDistance, defines the distance robot goes per manual move
    inDustBootUp = 1038 ; 1 if dust boot is raised
    inProgOption4 = 1039
    inProgOption5 = 1040
    inPcKill = 1041 ; PLC stop request, held on until outProgRunning drops (programcontrol.pc)
    
    ; programcontrol.pc state
    pcProg = 0 ; Program for pcrun to run; pcrun clears it when it starts
    pcArmed = 0 ; Program choice latched when start (1005) turned on; 0 = no pending start
    pcLaunched = 0 ; 1 while a program started by programcontrol.pc is running
    pcToolSent = 0 ; Program whose first tool was last sent to the PLC
    pcStartPrev = 0 ; Start (1005) on the previous pass, for edge detection
    pcRetryAt = 0 ; TIMER(0) time before which a failed launch is not retried
    pcBeat = 0 ; Heartbeat state written to outPcHeartbeat
    pcCurTool = 0 ; Current tool passed to changeTool (MC EXECUTE cannot pass arguments)
    pcReqTool = 0 ; Requested tool passed to changeTool
    ; First tool of each cutting program by program number (4 half inch,
    ; 2 quarter, 0 sawblade). The only place this is set: update it here when a program
    ; is changed to start with a different tool.
    firstTool[1] = 4 ; frontWall
    firstTool[2] = 4 ; backWall
    firstTool[3] = 0 ; Option3
    firstTool[4] = 4 ; Option4
    firstTool[5] = 4 ; cubeSaunaFront
    firstTool[6] = 0 ; Option5
    firstTool[7] = 4 ; Option6
    firstTool[8] = 4 ; Option7
    firstTool[9] = 4 ; Option9
    
    PCABORT 2:
    PCABORT 3:
    PCABORT 4:
    PCEXECUTE 2: posedata.pc, -1 ; Executes pose data continuously
    PCEXECUTE 3: pcwatch.pc
    PCEXECUTE 4: programcontrol.pc, -1 ; Executes program selection continuously
.END
