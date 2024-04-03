.PROGRAM poseData.pc()
; Program to send pose data via software IOs to PLC
;  map the TCP coordinates to 75 IOs (2^13=8192 digits each to represent +- 3000mm for X,Y,Z axes and 2^10=1024 digits each to represent +- 180deg for OAT).
; Convert HERE to decimal with DECOMPOSE pose[0] = HERE, then each element of pose is XYZOAT value
; Add 4000 for XYZ and 400 for OAT, USE ROUND or INT to make it integer
; Use BITS starting signal number, number of signals = decimal value 6-76

; Decompose the tool value, set to the middle. Then add/subtract and figure out the whole angles thing
   HERE #pose
   DECOMPOSE .joints[0] = #pose
   .jt1 = ROUND(.joints[0]*100) + 40000
   .jt2 = ROUND(.joints[1]*100) + 40000
   .jt3 = ROUND(.joints[2]*100) + 40000
   .jt4 = ROUND(.joints[3]*100) + 40000
   .jt5 = ROUND(.joints[4]*100) + 40000
   .jt6 = ROUND(.joints[5]*100) + 40000
   
   BITS 1,16 = .jt1 
   BITS 17,16 = .jt2
   BITS 33,16 = .jt3
   BITS 49,16 = .jt4
   BITS 65,16 = .jt5
   BITS 81,16 = .jt6

   DECOMPOSE .toolzheight[0] = HERE
   .ztool = ROUND(.toolzheight[2]) + 4000
   BITS 129,16 = .ztool 
.END
