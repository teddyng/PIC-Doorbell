    LIST    p=16f84a        ;tell assembler what chip we are using
    include "p16f84a.inc"        ;include the defaults for the chip
    __config _CP_OFF & _WDT_OFF & _XT_OSC ;sets the configuration settings
                    ;(oscillator type etc.)
    
LEDPORT    Equ    PORTB            ;set constant LEDPORT to be PORTB 
SWPORT    Equ    PORTB            ;set constant SWPORT = 'PORTB'
SWITCHPORT Equ    PORTA
SW1    Equ    0            ;set constants for the switches
SW2    Equ    1  
SW3    Equ    2
SW4    Equ    3
LED1    Equ    0            ;and for the LED's                
                    
    org    0x0000            ;org sets the origin,
                    ;this is where the program starts running    
    movlw    0x07            

       bsf     STATUS,        RP0    ;select bank 1
       movlw     b'00000010'        ;set PortB all outputs
       movwf     TRISB
    movlw     b'00001111'        ;set PortB all outputs
       movwf     TRISA
    bcf    STATUS,        RP0    ;set bank 0
    clrf    PORTB            ;clear PORTB 
    clrf    PORTA            ;clear PORTB 
    
Loop                    ;main loop, it waits for a HIGH pin from pin no 4
    btfsc    SWPORT,    1        ;which comes from the ESP8266
    call    SwitchMain        ;if it's HIGH, continue to another function which wil determine the switches.
    goto    Loop    
    
SwitchMain 
    call    Del50            ;give switch time to stop bouncing
    btfsc    SWPORT,    7        ;check if the speaker is HIGH, if it is it means it's already in progress and therefore 
                    ;return back to the initial loop if its working. 
    retlw    0x00            ;return back to the previous loop
    btfss    SWITCHPORT, SW1        ;if switch is low, means it is ON, therefore proceed to the Switch function
    goto    Switch1
    
    btfss    SWITCHPORT, SW2        ;if switch is low, means it is ON, therefore proceed to the Switch function
    goto    Switch2
    
    btfss    SWITCHPORT, SW3        ;if switch is low, means it is ON, therefore proceed to the Switch function
    goto    Switch3
    
    btfss    SWITCHPORT, SW4        ;if switch is low, means it is ON, therefore proceed to the Switch function
    goto    Switch4
    
Tune1            ;function for playing the specific tune, this one is for Switch1
            ;we're calling the note function note by note.
    call    ELoop
    call    ELoop
    call    ELoopL

    call    Del10
    call    ELoop
    call    ELoop
    call    ELoopL
    call    Del10

    call    ELoop
    call    GLoop
    call    CLoop
    call    DLoopS
    call    ELoopL
    call    Del20

    call    FLoop
    call    FLoop
    call    FLoopL
    call    FLoopS

    call    FLoop
    call    ELoop
    call    ELoop

    call    ELoopS
    call    ELoopS
    call    ELoop
    call    DLoop
    call    DLoop

    call    ELoop
    call    DLoopL
    call    GLoopL
    call    Del20

    call    ELoop
    call    ELoop
    call    ELoopL
    call    Del10

    call    ELoop
    call    ELoop
    call    ELoopL
    call    Del10

    call    ELoop
    call    GLoop
    call    CLoop
    call    DLoopS
    call    ELoopL
    call    Del20

    call    FLoop
    call    FLoop
    call    FLoopL

    call    FLoopS
    call    FLoop
    call    ELoop
    call    ELoop

    call    ELoopS
    call    ELoopS
    call    GLoop
    call    GLoop

    call    FLoop
    call    DLoop
    call    CLoopL
    return        ;after its finished, return back to the Switch function

Tune2            ;function for playing the specific tune, this one is for Switch2
            ;we're calling the note function note by note.    
    call    CLoop
    call    CLoop
    call    GLoop
    call    GLoop
    call    ALoop
    call    ALoop
    call    GLoopL

    call    Del10
    call    FLoop
    call    FLoop
    call    ELoop
    call    ELoop

    call    DLoop
    call    DLoop
    call    CLoopL
    
    call    Del20

    call    GLoop
    call    GLoop
    call    FLoop
    call    FLoop

    call    ELoop
    call    ELoop
    call    DLoopL
    
    call    Del10

    call    GLoop
    call    GLoop
    call    FLoop
    call    FLoop

    call    ELoop
    call    ELoop
    call    DLoopL

    call    Del20
    
    call    CLoop
    call    CLoop
    call    GLoop
    call    GLoop

    call    ALoop
    call    ALoop
    call    GLoopL

    call    FLoop
    call    FLoop
    call    ELoop
    call    ELoop

    call    DLoop
    call    DLoop
    call    CLoopL

    return    
    
Tune3            ;function for playing the specific tune, this one is for Switch3
            ;we're calling the note function note by note.

    call    GLoop
    call    GLoop
    call    GLoop
    call    DLoop

    call    ELoop
    call    ELoop
    call    DLoopL

    call    Del20
    
    call    BLoop
    call    BLoop
    call    ALoop
    call    ALoop
    call    GLoopL
    
    call    DLoop
    call    GLoop
    call    GLoop
    call    GLoop
    call    DLoop

    call    ELoop
    call    ELoop
    call    DLoopL

    Call    Del20
    
    call    BLoop
    call    BLoop
    call    ALoop
    call    ALoop
    call    GLoopL

    return    
    
Tune4            ;function for playing the specific tune, this one is for Switch4
            ;we're calling the note function note by note.    
    call    GLoopL
    call    ALoopS
    call    GLoop
    call    FLoop

    call    ELoop
    call    FLoop
    call    GLoopL
    
    call    Del10

    call    DLoop
    call    ELoop
    call    FLoopL
    
    call    Del10

    call    ELoop
    call    FLoop
    call    GLoopL
    
    call    Del10

    call    GLoopL
    call    ALoopS
    call    GLoop
    call    FLoop

    call    ELoop
    call    FLoop
    call    GLoopL

    call    Del10
    
    call    DLoopL
    call    GLoopL

    call    ELoop
    call    CLoop

    return        
    
Switch1    call    Del50            ;give switch time to stop bouncing
    btfsc    SWITCHPORT, SW1        ;check if switch is high
    retlw    0x00            ;if it is, return 
    btfss    SWPORT,    7        ;check if speaker is OFF
    goto    Tune1            ;if it is, play the tune
    
Switch2    call    Del50            ;give switch time to stop bouncing
    btfsc    SWITCHPORT, SW2        ;check if switch is high
    retlw    0x00            ;if it is, return 
    btfss    SWPORT,    7        ;check if speaker is OFF
    goto    Tune2            ;if it is, play the tune
    
Switch3    call    Del50            ;give switch time to stop bouncing
    btfsc    SWITCHPORT, SW3        ;check if switch is high
    retlw    0x00            ;if it is, return 
    btfss    SWPORT,    7        ;check if speaker is OFF
    goto    Tune3            ;if it is, play the tune    
    
Switch4    call    Del50            ;give switch time to stop bouncing
    btfsc    SWITCHPORT, SW4        ;check if switch is high
    retlw    0x00            ;if it is, return 
    btfss    SWPORT,    7        ;check if speaker is OFF
    goto    Tune4            ;if it is, play the tune        

LED1ON    bsf    LEDPORT, LED1    ;turn LED1 on
    call    Del50
    btfsc    SWPORT,    SW1    ;wait until the s
    retlw    0x00
    goto    LED1ON    

    
    cblock     0x20             ;start of general purpose registers
        count1             ;used in delay routine
        counta             ;used in delay routine 
        countb             ;used in delay routine
        D1            ;used in Tune routine
        D2            ;used in Tune routine
        J            ;used in Tune lenght routine
        K            ;used in Tune lenght routine
    endc

CLoop    
    movlw d'80'
    movwf J
a1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    CNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    CNote
a2loop:  
    decfsz K,f
    goto a2loop
    decfsz J,f
    goto a1loop
    
    return

DLoop    
    movlw d'80'
    movwf J
b1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    DNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    DNote
b2loop:  
    decfsz K,f
    goto b2loop
    decfsz J,f
    goto b1loop
    
    return
    
ELoop
    movlw d'80'
    movwf J
c1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    ENote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    ENote
c2loop:  
    decfsz K,f
    goto c2loop
    decfsz J,f
    goto c1loop
    return
    
FLoop
    movlw d'80'
    movwf J
d1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    FNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    FNote
d2loop:  
    decfsz K,f
    goto d2loop
    decfsz J,f
    goto d1loop    
    
    return
    
GLoop
    movlw d'80'
    movwf J
e1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    GNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    GNote
e2loop:  
    decfsz K,f
    goto e2loop
    decfsz J,f
    goto e1loop    
    
    return
    
ALoop
    movlw d'100'
    movwf J
f1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    ANote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    ANote
f2loop:  
    decfsz K,f
    goto f2loop
    decfsz J,f
    goto f1loop    
    return
    
BLoop
    movlw d'100'
    movwf J
g1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    BNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    BNote
g2loop:  
    decfsz K,f
    goto g2loop
    decfsz J,f
    goto g1loop
    return
    
CLoopL    
    movlw d'140'
    movwf J
h1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    CNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    CNote
h2loop:  
    decfsz K,f
    goto h2loop
    decfsz J,f
    goto h1loop
    
    return

DLoopL    
    movlw d'140'
    movwf J
i1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    DNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    DNote
i2loop:  
    decfsz K,f
    goto i2loop
    decfsz J,f
    goto i1loop
    
    return

ELoopL
    movlw d'140'
    movwf J
j1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    ENote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    ENote
j2loop:  
    decfsz K,f
    goto j2loop
    decfsz J,f
    goto j1loop
    return
    
FLoopL
    movlw d'140'
    movwf J
k1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    FNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    FNote
k2loop:  
    decfsz K,f
    goto k2loop
    decfsz J,f
    goto k1loop    
    
    return
    
GLoopL
    movlw d'140'
    movwf J
l1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    GNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    GNote
l2loop:  
    decfsz K,f
    goto l2loop
    decfsz J,f
    goto l1loop    
    
    return    
    
DLoopS    
    movlw d'40'
    movwf J
m1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    DNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    DNote
m2loop:  
    decfsz K,f
    goto m2loop
    decfsz J,f
    goto m1loop
    
    return
    
ELoopS
    movlw d'40'
    movwf J
n1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    ENote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    ENote
n2loop:  
    decfsz K,f
    goto n2loop
    decfsz J,f
    goto n1loop
    return
    
FLoopS
    movlw d'40'
    movwf J
o1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    FNote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    FNote
o2loop:  
    decfsz K,f
    goto o2loop
    decfsz J,f
    goto o1loop    
    
    return

ALoopS
    movlw d'40'
    movwf J
p1loop: 
    movwf K
    movlw    0xff
    movwf    PORTB
    nop                ;the nop's make up the time taken by the goto
    nop                ;giving a square wave output
    call    ANote            ;this waits for a while!
    movlw    0x00
    movwf    PORTB            ;set all bits off
    call    ANote
p2loop:  
    decfsz K,f
    goto p2loop
    decfsz J,f
    goto p1loop    
    return
    
CNote
            ;3803 cycles
    movlw    0xF8
    movwf    D1
    movlw    0x03
    movwf    D2
CNote_0
    decfsz    D1, f
    goto    $+2
    decfsz    D2, f
    goto    CNote_0
            ;3 cycles
    goto    $+1
    nop
            ;4 cycles (including call)
    return
    
    
DNote
            ;3393 cycles
    movlw    0xA6
    movwf    D1
    movlw    0x03
    movwf    D2
DNote_0
    decfsz    D1, f
    goto    $+2
    decfsz    D2, f
    goto    DNote_0
            ;4 cycles
    goto    $+1
    goto    $+1
            ;4 cycles (including call)
    return
    
ENote
            ;3023 cycles
    movlw    0x5C
    movwf    D1
    movlw    0x03
    movwf    D2
ENote_0
    decfsz    D1, f
    goto    $+2
    decfsz    D2, f
    goto    ENote_0
            ;3 cycles
    goto    $+1
    nop
            ;4 cycles (including call)
    return    
    
FNote
            ;2858 cycles
    movlw    0x3B
    movwf    D1
    movlw    0x03
    movwf    D2
FNote_0
    decfsz    D1, f
    goto    $+2
    decfsz    D2, f
    goto    FNote_0
            ;3 cycles
    goto    $+1
    nop
            ;4 cycles (including call)
    return
    
GNote
            ;2543 cycles
    movlw    0xFC
    movwf    D1
    movlw    0x02
    movwf    D2
GNote_0
    decfsz    D1, f
    goto    $+2
    decfsz    D2, f
    goto    GNote_0
            ;3 cycles
    goto    $+1
    nop
            ;4 cycles (including call)
    return    

ANote
            ;2263 cycles
    movlw    0xC4
    movwf    D1
    movlw    0x02
    movwf    D2
ANote_0
    decfsz    D1, f
    goto    $+2
    decfsz    D2, f
    goto    ANote_0
            ;3 cycles
    goto    $+1
    nop
            ;4 cycles (including call)
    return    
    
BNote
            ;2013 cycles
    movlw    0x92
    movwf    D1
    movlw    0x02
    movwf    D2
BNote_0
    decfsz    D1, f
    goto    $+2
    decfsz    D2, f
    goto    BNote_0
            ;3 cycles
    goto    $+1
    nop
            ;4 cycles (including call)
    return        
    
    ;//////////// GENERAL DELAYS ////////////////
Del0    retlw    0x00            ;delay 0mS - return immediately
Del1    movlw    d'1'            ;delay 1mS
    goto    Delay
Del5    movlw    d'5'            ;delay 5mS
    goto    Delay
Del10    movlw    d'10'            ;delay 10mS
    goto    Delay
Del20    movlw    d'20'            ;delay 20mS
    goto    Delay
Del50    movlw    d'50'            ;delay 50mS
    goto    Delay
Del100    movlw    d'100'            ;delay 100mS
    goto    Delay
Del250    movlw    d'250'            ;delay 250 ms
    
Delay    movwf    count1
d1    movlw    0xC7            ;delay 1mS
    movwf    counta
    movlw    0x01
    movwf    countb
Delay_0
    decfsz    counta, f
    goto    $+2
    decfsz    countb, f
    goto    Delay_0

    decfsz    count1    ,f
    goto    d1
    retlw    0x00
    end      
