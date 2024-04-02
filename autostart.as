.PROGRAM autostart.pc()
    PCABORT 2:
    PCEXECUTE 2: posedata.pc, -1 ; Executes pose data continuously
    ; WAIT SIG(1012) ; E stop ethercat
    WAIT SWITCH(POWER)
    WAIT NOT SIG(98)
    MC EXECUTE progcontrol, -1
.END
