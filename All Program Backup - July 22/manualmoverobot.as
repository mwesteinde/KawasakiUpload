.PROGRAM manualmoverobot()
    ; Set initial speed and distance for jogging
    SPEED 50 MM/S ALWAYS
    HERE .current_pos
    .jog_increment[0] = 0.1
    .jog_increment[1] = 0.5
    .jog_increment[2] = 1
    .jog_increment[3] = 5
    .jog_increment[4] = 10
    .jog_increment[5] = 20
    .jog_increment[6] = 50

    ; Infinite loop to check the bit status continuously
    WHILE TRUE DO
        IF SIG(inxmove) THEN  ; Check if the bit for X+ motion is ON
            IF SIG(inmovepositive) THEN
                LMOVE SHIFT(HERE BY .jog_increment[BITS(inManMoveDstnce, 3)], 0, 0)
            ELSE
                LMOVE SHIFT(HERE BY -.jog_increment[BITS(inManMoveDstnce, 3)], 0, 0)
            END
        END
        IF SIG(inymove) THEN  ; Check if the bit for Y+ motion is ON
            IF SIG(inmovepositive) THEN
                LMOVE SHIFT(HERE BY 0, .jog_increment[BITS(inManMoveDstnce, 3)], 0)
            ELSE
                LMOVE SHIFT(HERE BY 0, -.jog_increment[BITS(inManMoveDstnce, 3)], 0)
            END
        END
        IF SIG(inzmove) THEN  ; Check if the bit for Z+ motion is ON
            IF SIG(inmovepositive) THEN
                LMOVE SHIFT(HERE BY 0, 0, .jog_increment[BITS(inManMoveDstnce, 3)])
            ELSE
                LMOVE SHIFT(HERE BY 0, 0, -.jog_increment[BITS(inManMoveDstnce, 3)])
            END
        END
        ; Small delay to avoid CPU overload
        DELAY 0.1
    END
.END
