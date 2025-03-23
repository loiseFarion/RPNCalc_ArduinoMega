;************************************************************************
; Vetor de Reset
;************************************************************************

.org  0x00  ;

jmp inicio
.include "pausas.inc"

;************************************************************************
; Configuraçõeses iniciais
;************************************************************************

inicio:
  ldi   r16,0b11111111        ;seta como ouput(1) saída do PORTL
  out   DDRA,r16
  ldi   r16,0b00000000        ;seta como down
  out   PORTA,r16
  ldi   r19,0b11111111        ;seta como ouput(1) saída do PORTB
  out   DDRC,r19
  ldi   r19,0b00000000        ;seta como down
  out   PORTC,r19
  ldi   r17,0
  ldi   r18,0

;************************************************************************
; loop principal
;************************************************************************
  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010
  ldi  r17,0b00000101
  ldi  r18,0b00000101
  ldi  r19,0b00000000
  add r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start0:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start0  ; salta de volta para o início do loop se r16 não for zero

  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010
  ldi  r17,0b00000000
  ldi  r18,0b00000010
  ldi  r19,0b00000000
  add r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start1:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start1  ; salta de volta para o início do loop se r16 não for zero

  ldi  r18,0b00000010
  ldi  r17,0b00000011
  ldi  r19,0b00000000
  ldi  r21, 0b00000001
  multiplicacao2:
    mul r21, r17
    mov r21, r0  ;selecionando a parte baixa da multiplicação
    dec r18  
    brne multiplicacao2  
    mov r17, r0
  ldi  r17,0b00001001
  ldi  r18,0b00000010
  ldi  r19,0b00000000
  clr  r20 ;contador
  ldi  r22, 0b00000000 
  ldi  r24, 0b00000000 
  loopDiv3:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroDiv3; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo floatDiv3 ; se menor termina
    rjmp loopDiv3; continua a dividir
  zeroDiv3:
    mov r17, r20
    rjmp fimDiv3
  floatDiv3:
    mov r24, r17
    ldi r23, 0b00001010
    mul r24, r23
    mov r24, r0
    rjmp loopFloatDiv3 
  loopFloatDiv3:
    sub r24, r18
    inc r19
    cp r24, r22
    breq zeroFloatDiv3; se for 0 vai para a função zero
    cp r24,r18; compara se o numerador é menor que divisor
    brlo zeroFloatDiv3 ; se menor termina
    rjmp loopFloatDiv3; continua a dividir
  zeroFloatDiv3:
    mov r17, r20;envia float
  fimDiv3:
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start2:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start2  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00000010
  ldi  r18,0b00000011
  clr r19
  mul r17, r18
  mov r17, r0 ;selecionando a parte baixa da multiplicação
  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010
  ldi  r17,0b00000100
  ldi  r18,0b00000110
  ldi  r19,0b00000000
  add r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start3:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start3  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00000110
  ldi  r18,0b00000110
  clr r19
  mul r17, r18
  mov r17, r0 ;selecionando a parte baixa da multiplicação
  ldi  r17,0b00001000
    ldi  r18,0b00000010
  clr  r19 
          sub r17, r18 ; Soma e armazena no r17
  ldi  r17,0b00100100
  ldi  r18,0b00000110
  ldi  r19,0b00000000
  clr  r20 ;contador
  ldi  r22, 0b00000000
  loopDivInt5:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroDivInt5; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo zeroDivInt5 ; se menor termina
    rjmp loopDivInt5; continua a dividir
  zeroDivInt5:
     mov r17, r20
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start4:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start4  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00011001
  ldi  r18,0b00000011
  ldi  r19,0b00000000
  clr  r20; contador
  ldi  r22, 0b00000000
  loopResto5:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroResto5; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo zeroResto5; se menor termina
    rjmp loopResto5; continua a dividir
  zeroResto5:
     ;resto vazio
  ldi  r17,0b01010001
  ldi  r18,0b00001001
  ldi  r19,0b00000000
  clr  r20 ;contador
  ldi  r22, 0b00000000 
  ldi  r24, 0b00000000 
  loopDiv6:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroDiv6; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo floatDiv6 ; se menor termina
    rjmp loopDiv6; continua a dividir
  zeroDiv6:
    mov r17, r20
    rjmp fimDiv6
  floatDiv6:
    mov r24, r17
    ldi r23, 0b00001010
    mul r24, r23
    mov r24, r0
    rjmp loopFloatDiv6 
  loopFloatDiv6:
    sub r24, r18
    inc r19
    cp r24, r22
    breq zeroFloatDiv6; se for 0 vai para a função zero
    cp r24,r18; compara se o numerador é menor que divisor
    brlo zeroFloatDiv6 ; se menor termina
    rjmp loopFloatDiv6; continua a dividir
  zeroFloatDiv6:
    mov r17, r20;envia float
  fimDiv6:
  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010
  ldi  r17,0b00000001
  ldi  r18,0b00001001
  ldi  r19,0b00000000
  add r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start5:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start5  ; salta de volta para o início do loop se r16 não for zero

  ldi  r18,0b00000010
  ldi  r17,0b00000101
  ldi  r19,0b00000000
  ldi  r21, 0b00000001
  multiplicacao6:
    mul r21, r17
    mov r21, r0  ;selecionando a parte baixa da multiplicação
    dec r18  
    brne multiplicacao6  
    mov r17, r0
  ldi  r17,0b00011001
    ldi  r18,0b00001010
  clr  r19 
          sub r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start6:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start6  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00000011
  ldi  r18,0b00000110
  clr r19
  mul r17, r18
  mov r17, r0 ;selecionando a parte baixa da multiplicação
  ldi  r17,0b00110111
    ldi  r18,0b00010010
  clr  r19 
          sub r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start7:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start7  ; salta de volta para o início do loop se r16 não for zero

  ldi  r18,0b00000010
  ldi  r17,0b00000101
  ldi  r19,0b00000000
  ldi  r21, 0b00000001
  multiplicacao8:
    mul r21, r17
    mov r21, r0  ;selecionando a parte baixa da multiplicação
    dec r18  
    brne multiplicacao8  
    mov r17, r0
  ldi  r17,0b00011001
    ldi  r18,0b00001010
  clr  r19 
          sub r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start8:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start8  ; salta de volta para o início do loop se r16 não for zero

  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010
  ldi  r17,0b00000010
  ldi  r18,0b00001111
  ldi  r19,0b00000000
  add r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start9:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start9  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00000110
  ldi  r18,0b00000010
  clr r19
  mul r17, r18
  mov r17, r0 ;selecionando a parte baixa da multiplicação
  ldi  r17,0b00001100
  ldi  r18,0b00000100
  ldi  r19,0b00000000
  clr  r20 ;contador
  ldi  r22, 0b00000000
  loopDivInt11:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroDivInt11; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo zeroDivInt11 ; se menor termina
    rjmp loopDivInt11; continua a dividir
  zeroDivInt11:
     mov r17, r20
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start10:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start10  ; salta de volta para o início do loop se r16 não for zero

  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010
  ldi  r17,0b00001111
  ldi  r18,0b00000110
  ldi  r19,0b00000000
  add r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start11:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start11  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00001010
  ldi  r18,0b00000100
  ldi  r19,0b00000000
  clr  r20; contador
  ldi  r22, 0b00000000
  loopResto12:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroResto12; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo zeroResto12; se menor termina
    rjmp loopResto12; continua a dividir
  zeroResto12:
     ;resto vazio
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start12:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start12  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00000010
  ldi  r18,0b00000011
  clr r19
  mul r17, r18
  mov r17, r0 ;selecionando a parte baixa da multiplicação
  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010
  ldi  r17,0b00001100
  ldi  r18,0b00000110
  ldi  r19,0b00000000
  add r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start13:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start13  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00011110

            ldi  r18,0b00001111
  sub r17, r18 ; Soma e armazena no r17
  clr r20 ;contador
  clr r19
  ldi r22, 0b00000000 
  ldi r24, 0b00000000 
  ldi r25, 0b00001010 
  loop15:
     sub r17, r25
     inc r20
     cp r17, r22
     breq zero15; se for 0 vai para a função zero
     cp r17,r25; compara se o numerador é menor que divisor
     brlo float15 ; se menor termina
     rjmp loop15; continua a dividir
  zero15:
     mov r17, r20
  float15:
     mov r24, r17  
     ldi r23, 0b00001010 ;
     mul r24, r23
     mov r24, r0
     rjmp loopFloat15 
  loopFloat15:
    sub r24, r25
    inc r19
    cp r24, r22
    breq zeroFloat15; se for 0 vai para a função zero
    cp r24,r25; compara se o numerador é menor que divisor
    brlo zeroFloat15 ; se menor termina
    rjmp loopFloat15; continua a dividir
  zeroFloat15:     
    mov r17, r20;envia float

  clr r31
  ldi r31, 0b10000000
  or r19, r31
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start14:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start14  ; salta de volta para o início do loop se r16 não for zero

  ldi  r17,0b00000010
  ldi  r18,0b00000011
  clr r19
  mul r17, r18
  mov r17, r0 ;selecionando a parte baixa da multiplicação
  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010
  ldi  r17,0b00001100
  ldi  r18,0b00000110
  ldi  r19,0b00000000
  add r17, r18 ; Soma e armazena no r17
  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start15:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start15  ; salta de volta para o início do loop se r16 não for zero

  clr r16
  clr r19
  out PORTA, r16 ; finaliza saida
  out PORTC, r19 ; finaliza saida
  finalizaSaida:
    nop  ; Nenhuma operação
    rjmp finalizaSaida