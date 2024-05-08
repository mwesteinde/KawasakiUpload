.PROGRAM toolcheck.pc()
   DECOMPOSE .currenttool[0] = TOOL
   .xtool = ROUND(.currenttool[0]) + 4094/2
   .ytool = ROUND(.currenttool[1]) + 4094/2
   .ztool = ROUND(.currenttool[2]) + 4094/2

   IF .xtool > 4096 OR .ytool > 4096 OR .ztool > 4096 Then
      ;error
   END

   BITS 145,12 = .xtool 
   BITS 157,12 = .ytool
   BITS 169,12 = .ztool

   IF SYSDATA(STEP) == 1 THEN
      BITS outStartofProgram, 1 = 1
   ELSE
      BITS outStartofProgram, 1 = 0
   END
.END
