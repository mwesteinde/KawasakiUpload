.PROGRAM homeRobot1000()
    rollerHeight = 800
    BASE TRANS(0.0000,0.0000,0.000,0.0000,0.0000,0.0000)
    ACCURACY 1.000 ALWAYS
    SPEED 300.0 MM/S ALWAYS
    PRINT "HOME"
    DECOMPOSE currentPose[0] = HERE
    IF currentPose[2] < rollerHeight THEN
        LMOVE SHIFT(HERE BY 0,0,rollerHeight-currentPose[2])
        JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
    ELSE
        JMOVE #[0, 0, -15, 0, -30, 0] ; Move to home
    END
    PRINT "DONE"
    BASE NULL
.END
