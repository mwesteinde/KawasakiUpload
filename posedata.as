.PROGRAM poseData.pc()
; Program to send pose data via software IOs to PLC
;  map the TCP coordinates to 75 IOs (2^13=8192 digits each to represent +- 3000mm for X,Y,Z axes and 2^10=1024 digits each to represent +- 180deg for OAT).
; Convert HERE to decimal with DECOMPOSE pose[0] = HERE, then each element of pose is XYZOAT value
; Add 4000 for XYZ and 400 for OAT, USE ROUND or INT to make it integer
; Use BITS starting signal number, number of signals = decimal value 6-76
   DECOMPOSE .pose[0] = HERE
   .x = ROUND(.pose[0]) + 4000
   .y = ROUND(.pose[1]) + 4000
   .z = ROUND(.pose[2]) + 4000
   .o = ROUND(.pose[3]) + 400
   .a = ROUND(.pose[4]) + 400
   .t = ROUND(.pose[5]) + 400
   
   BITS 1,13 = .x 
   BITS 17,13 = .y
   BITS 33,13 = .z
   BITS 49,10 = .o
   BITS 65,10 = .a
   BITS 81,10 = .t
.END
