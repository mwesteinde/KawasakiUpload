.PROGRAM moveToCalibrate()
    CALL homeRobot
    SPEED 300.0 MM/S ALWAYS
    IF BITS(inProgOption1, 1) == 0 THEN
        TOOL TRANS(74.810,193.109,509.605,89.9440,45.0180,1.4720)
    ELSE
        TOOL TRANS(0.940,134.509,453.894,90.0010,45.0000,-0.0010)
    END
    JMOVE toolCalibrationHome
    CALL manualmoverobot
 .END
