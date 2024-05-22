.PROGRAM Option()
  .firstToolIndex = 4 ;First tool - 4 for half inch, 2 quarter, 0 sawblade
;DONT CHANGE
BITS outRequestTool, 4 = .firstToolIndex
BITS outToolUpdated, 1 = 1
WAIT SIG(inProgramStart)
BITS outToolUpdated, 1 = 0
BITS outProgRunning, 1 = 1
  
  ACCURACY 1.000 ALWAYS
  TYPE "/'WstBckChimyHf'"
  TYPE "/''"
  TYPE "/'ChimyHf'"
  SPEED 300.0 MM/S ALWAYS
  BASE TRANS(6.850,0.000,-4.000,0.0000,0.0000,0.0000)
  TOOL TRANS(0.292,133.845,454.558,90.0007,44.9998,-0.0010)
    JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
  JMOVE #[-5, 0, -15, 0, -30, 0] ; Move to home
  Delay(5)
  JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
    
    CALL changeTool(4,0)

  ACCURACY 1.000 ALWAYS
  TYPE "/'WstFntGlsDrBlNS'"
  TYPE "/''"
  TYPE "/'GlsDrBlNS'"
  SPEED 300.0 MM/S ALWAYS
  BASE TRANS(6.850,0.000,-4.000,0.0000,0.0000,0.0000)
  TOOL TRANS(74.078,192.463,508.959,89.9440,45.0180,1.4720)
  ; Show Sawblade
  JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
  JMOVE #[-5, 0, -15, 0, -30, 0] ; Move to home
  JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home



 .END

