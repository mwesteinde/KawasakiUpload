.PROGRAM Option3()
.firstToolIndex = 0 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
;DONT CHANGE
BITS outRequestTool, 4 = .firstToolIndex
BITS outToolUpdated, 1 = 1
WAIT SIG(inProgramStart)
BITS outToolUpdated, 1 = 0
BITS outProgRunning, 1 = 1
CALL wstcbfnttrace77
CALL homeRobot
.END
