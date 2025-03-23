pausa_R16_us: 
  nop		; pausa 1 
  nop	
  nop	
  nop
  nop

pausa_R16_us_loop:
  cpi		R16,1
  breq	pausa_R16_end

  nop		; pausa 2
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  dec		R16
  jmp		pausa_R16_us_loop

pausa_R16_end:
  ret

pausa_R17_ms:
  ldi		R16, 250 ;pausa 1
  call	pausa_R16_us
  ldi		R16, 250
  call	pausa_R16_us
  ldi		R16, 250
  call	pausa_R16_us
  ldi		R16, 249
  call	pausa_R16_us
  nop

pausa_R17_ms_loop:
  cpi		R17,1 ;pausa 2
  breq	pausa_R17_end

  ldi		R16, 250 
  call	pausa_R16_us
  ldi		R16, 250
  call	pausa_R16_us
  ldi		R16, 250
  call	pausa_R16_us
  ldi		R16, 249
  call	pausa_R16_us
  nop
  nop
  nop
  nop
  nop

  dec		R17
  jmp		pausa_R17_ms_loop

pausa_R17_end:
  ret