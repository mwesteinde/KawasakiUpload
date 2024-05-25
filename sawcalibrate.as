.PROGRAM moveToCalibrate()
    CALL homeRobot
    JMOVE CalibrationHome
    IF BITS(inCurrentTool, 4) == 0 THEN
        TOOL TRANS(74.810,193.109,509.605,89.9440,45.0180,1.4720)
    ELSE
        TOOL TRANS(0.940,134.509,453.894,90.0010,45.0000,-0.0010)
    END
    LMOVE toolCalibrationTop
 .END
