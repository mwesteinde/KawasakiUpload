.PROGRAM manualmoverobot()
    ; Set initial speed and distance for jogging
    SPEED 50 MM/S ALWAYS
    HERE .current_pos
    .jog_increment = 10

    ; Infinite loop to check the bit status continuously
    WHILE TRUE DO
        IF SIG(inxmove) THEN  ; Check if the bit for X+ motion is ON
            IF SIG(inmovepositive) THEN
                LMOVE SHIFT(HERE BY .jog_increment, 0, 0)
            ELSE
                LMOVE SHIFT(HERE BY -10, 0, 0)
            END
        END
        IF SIG(inymove) THEN  ; Check if the bit for Y+ motion is ON
            IF SIG(inmovepositive) THEN
                LMOVE SHIFT(HERE BY 0, 10, 0)
            ELSE
                LMOVE SHIFT(HERE BY 0, -10, 0)
            END
        END
        IF SIG(inzmove) THEN  ; Check if the bit for Z+ motion is ON
            IF SIG(inmovepositive) THEN
                LMOVE SHIFT(HERE BY 0, 0, 10)
            ELSE
                LMOVE SHIFT(HERE BY 0, 0, -10)
            END
        END
        ; Small delay to avoid CPU overload
        DELAY 0.1
    END
.END
