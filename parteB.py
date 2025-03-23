# Helena Kuchinski Ferreira
# Loise Andruski Farion
# Grupo Projeto Compilador 5
import sys
import re


def resolve(expressao, memoria, file, k):

  expressao = expressao.replace('MEM', str(memoria))
  expressao = expressao.replace(',', '.')
  elementos = re.findall(r'[\d.]+|[()+\-*^/%|]', expressao)
  pilha = []
  for elemento in elementos:
    if elemento.isdigit() or re.match(r'\d+\.\d+', elemento):
      pilha.append(float(elemento))
    elif elemento == '(':
      pilha.append('(')
    elif elemento == ')':
      subexpressao = []
      while pilha[-1] != '(':
        subexpressao.insert(0, pilha.pop())
      pilha.pop()
      resultado_subexpressao = resolve_subexpressao(subexpressao, file, k)
      pilha.append(resultado_subexpressao)
    else:
      pilha.append(elemento)

  resultado_final = resolve_subexpressao(pilha, file, k)
  if resultado_final < 0:
    file.write('''\n  clr r31
  ldi r31, 0b10000000
  or r19, r31\n''')
  file.write(f'''  mov r16, r17 ; movimenta o r17 para r16
  out PORTA, r16 ; mostra resultado
  out PORTC, r19 ; mostra resultado

  ldi r30, 0b00111100  ; número de iterações 
  ldi r18, 0b00000000   
  loop_start{k}:
    ldi r17, 250
    call pausa_r17_ms
    dec r30       ; decrementa o contador
    cp r30, r18
    brne loop_start{k}  ; salta de volta para o início do loop se r16 não for zero\n\n'''
             )
  return resultado_final


def resolve_subexpressao(subexpressao, file, k):
  pilha = []
  while subexpressao:
    i = 0
    elemento = subexpressao.pop(0)
    if elemento == 'MEM':
      elemento = memoria
    if elemento in {'+', '-', '*', '|', '/', '^', '%'}:
      operando2 = pilha.pop()
      operando1 = pilha.pop()
      if elemento == '+':
        k += 1
        file.write('''  ldi  r23,0b00000000
  ldi  r24,0b00000000
  ldi  r21,0b00001010\n''')
        if int(operando1) == operando1:
          file.write(f'''  ldi  r17,0b{int(operando1):08b}\n''')
        else:
          operando1Decimal = int(str(operando1).split('.')[1])
          file.write(
              f'''  ldi  r17,0b{int(operando1):08b}\n  ldi  r23,0b{int(operando1Decimal):08b}\n'''
          )

        if int(operando2) == operando2:
          file.write(f'''  ldi  r18,0b{int(operando2):08b}\n''')
        else:
          operando2Decimal = int(str(operando2).split('.')[1])
          file.write(
              f'''  ldi  r18,0b{int(operando2):08b}\n  ldi  r24,0b{int(operando2Decimal):08b}\n'''
          )

        if int(operando1) == operando1 and int(operando2) == operando2:
          file.write(
              '''  ldi  r19,0b00000000\n  add r17, r18 ; Soma e armazena no r17\n'''
          )

        else:
          file.write(f'''  add r23, r24 ; Soma o decimal
  cp r23, r21
  brsh intFloat{k} ;se maior ou igual vai para intFloat
  mov r19, r23 ;se não atribui o decimal
  add r17, r18
  rjmp fim{k}
  intFloat{k}:
    sub r23, r21
    mov r19, r23
    add r17, r18
    inc r17
  fim{k}:\n''')
        pilha.append(operando1 + operando2)

      elif elemento == '-':
        k += 1
        if int(operando1) == operando1 and int(operando2) == operando2:
          if operando1 > operando2:
            file.write(f'''  ldi  r17,0b{int(operando1):08b}
    ldi  r18,0b{int(operando2):08b}\n''')
          if operando2 > operando1:
            file.write(f'''  ldi  r17,0b{int(operando2):08b}
    ldi  r18,0b{int(operando1):08b}\n''')
          file.write('''  clr  r19 
          sub r17, r18 ; Soma e armazena no r17\n''')
          pilha.append(operando1 - operando2)
        else:
          operando1 = operando1 * 10
          operando2 = operando2 * 10
          if operando1 > operando2:
            file.write(f'''  ldi  r17,0b{int(operando1):08b}\n
            ldi  r18,0b{int(operando2):08b}\n''')
          if operando2 > operando1:
            file.write(f'''  ldi  r17,0b{int(operando2):08b}\n
            ldi  r18,0b{int(operando1):08b}\n''')
          file.write(f'''  sub r17, r18 ; Soma e armazena no r17
  clr r20 ;contador
  clr r19
  ldi r22, 0b00000000 
  ldi r24, 0b00000000 
  ldi r25, 0b00001010 
  loop{k}:
     sub r17, r25
     inc r20
     cp r17, r22
     breq zero{k}; se for 0 vai para a função zero
     cp r17,r25; compara se o numerador é menor que divisor
     brlo float{k} ; se menor termina
     rjmp loop{k}; continua a dividir
  zero{k}:
     mov r17, r20
  float{k}:
     mov r24, r17  
     ldi r23, 0b00001010 ;
     mul r24, r23
     mov r24, r0
     rjmp loopFloat{k} 
  loopFloat{k}:
    sub r24, r25
    inc r19
    cp r24, r22
    breq zeroFloat{k}; se for 0 vai para a função zero
    cp r24,r25; compara se o numerador é menor que divisor
    brlo zeroFloat{k} ; se menor termina
    rjmp loopFloat{k}; continua a dividir
  zeroFloat{k}:     
    mov r17, r20;envia float\n''')
          pilha.append((operando1 - operando2) / 10)

      elif elemento == '*':
        k += 1
        if int(operando1) == operando1 and int(operando2) == operando2:
          file.write(f'''  ldi  r17,0b{int(operando1):08b}
  ldi  r18,0b{int(operando2):08b}
  clr r19
  mul r17, r18
  mov r17, r0 ;selecionando a parte baixa da multiplicação\n''')
          pilha.append(operando1 * operando2)
        else:
          if int(operando1) != operando1:
            operando1 = round(operando1, 1) * 10
            file.write(f'''  ldi  r17,0b{int(operando1):08b}\n''')
            if type(operando2) != int:
              operando2 = round(operando2, 0)
              file.write(f'''  ldi  r18,0b{int(operando2):08b}\n''')
            else:
              file.write(f'''  ldi  r18,0b{int(operando2):08b}\n''')
          if int(operando1) == operando1 and int(operando2) != operando2:
            operando1 = round(operando1, 0)
            file.write(f'''  ldi  r17,0b{int(operando1):08b}\n''')
            if type(operando2) != int:
              operando2 = round(operando2, 1) * 10
              file.write(f'''  ldi  r18,0b{int(operando2):08b}\n''')

          file.write(f'''  mul r17, r18
  mov r17, r0
  clr r20 ;contador
  clr r19 
  ldi r22, 0b00000000
  ldi r24, 0b00000000
  ldi r25, 0b00001010
  loopMult{k}:
    sub r17, r25
    inc r20
    cp r17, r22
    breq zeroFloatMult{k}; se for 0 vai para a função zero
    cp r17,r25; compara se o numerador é menor que divisor
    brlo floatMult{k} ; se menor termina
    rjmp loopMult{k}; continua a dividir
  floatMult{k}:
    mov r24, r17
    ldi r23, 0b00001010
    mul r24, r23
    mov r24, r0
    rjmp loopFloatMult{k}
  loopFloatMult{k}:
    sub r24, r25
    inc r19
    cp r24, r22
    breq zeroFloatMult{k}; se for 0 vai para a função zero
    cp r24,r25; compara se o numerador é menor que divisor
    brlo zeroFloatMult{k}; se menor termina
    rjmp loopFloatMult{k}; continua a dividir
  zeroFloatMult{k}:
     mov r17, r20; envia float\n''')
          pilha.append((operando1 * operando2) / 10)

      elif elemento == '|':
        k += 1
        if operando2 != 0:
          if float(operando1) != int(operando1):
            operando1 = round(operando1, 1) * 10
            file.write(f'  ldi  r17,0b{int(operando1):08b}\n')
            file.write(f'''  ldi  r18,0b{int(operando2):08b}
  ldi  r19,0b00000000
  clr  r20 ;contador
  ldi  r22, 0b00000000 
  ldi  r24, 0b00000000 
  loopDiv{k}:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroDiv{k}; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo floatDiv{k} ; se menor termina
    rjmp loopDiv{k}; continua a dividir
  zeroDiv{k}:
    mov r17, r20
    ldi r18, 0b00001010
    clr r20
    rjmp loopDiv{k}
  floatDiv{k}:
    mov r24, r17
    ldi r23, 0b00001010
    mul r24, r23
    mov r24, r0
    rjmp loopFloatDiv{k} 
  loopFloatDiv{k}:
    sub r24, r18
    inc r19
    cp r24, r22
    breq zeroFloatDiv{k}; se for 0 vai para a função zero
    cp r24,r18; compara se o numerador é menor que divisor
    brlo zeroFloatDiv{k} ; se menor termina
    rjmp loopFloatDiv{k}; continua a dividir
  zeroFloatDiv{k}:
    mov r17, r20;envia float\n''')
            pilha.append((operando1 / operando2) / 10)
          else:
            file.write(f'  ldi  r17,0b{int(operando1):08b}\n')
            pilha.append(operando1 / operando2)
            file.write(f'''  ldi  r18,0b{int(operando2):08b}
  ldi  r19,0b00000000
  clr  r20 ;contador
  ldi  r22, 0b00000000 
  ldi  r24, 0b00000000 
  loopDiv{k}:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroDiv{k}; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo floatDiv{k} ; se menor termina
    rjmp loopDiv{k}; continua a dividir
  zeroDiv{k}:
    mov r17, r20
    rjmp fimDiv{k}
  floatDiv{k}:
    mov r24, r17
    ldi r23, 0b00001010
    mul r24, r23
    mov r24, r0
    rjmp loopFloatDiv{k} 
  loopFloatDiv{k}:
    sub r24, r18
    inc r19
    cp r24, r22
    breq zeroFloatDiv{k}; se for 0 vai para a função zero
    cp r24,r18; compara se o numerador é menor que divisor
    brlo zeroFloatDiv{k} ; se menor termina
    rjmp loopFloatDiv{k}; continua a dividir
  zeroFloatDiv{k}:
    mov r17, r20;envia float
  fimDiv{k}:\n''')

      elif elemento == '/':  #divisao por inteiro
        k += 1
        if operando2 != 0:
          operando1 = int(operando1)
          operando2 = int(operando2)
          file.write(f'''  ldi  r17,0b{int(operando1):08b}
  ldi  r18,0b{int(operando2):08b}
  ldi  r19,0b00000000
  clr  r20 ;contador
  ldi  r22, 0b00000000
  loopDivInt{k}:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroDivInt{k}; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo zeroDivInt{k} ; se menor termina
    rjmp loopDivInt{k}; continua a dividir
  zeroDivInt{k}:
     mov r17, r20\n''')
        pilha.append(operando1 // operando2)

      elif elemento == '%':
        operando1 = int(operando1)
        operando2 = int(operando2)
        file.write(f'''  ldi  r17,0b{int(operando1):08b}
  ldi  r18,0b{int(operando2):08b}
  ldi  r19,0b00000000
  clr  r20; contador
  ldi  r22, 0b00000000
  loopResto{k}:
    sub r17, r18
    inc r20
    cp r17, r22
    breq zeroResto{k}; se for 0 vai para a função zero
    cp r17,r18; compara se o numerador é menor que divisor
    brlo zeroResto{k}; se menor termina
    rjmp loopResto{k}; continua a dividir
  zeroResto{k}:
     ;resto vazio\n''')
        pilha.append(operando1 % operando2)

      elif elemento == '^':
        contador = 0
        if type(operando2) != int:
          operando2 = int(operando2)
        if operando2 < 0:
          operando2 = abs(operando2)
          file.write(f'  ldi  r18,0b{int(operando2):08b}\n')
        if int(operando2) == operando2:
          file.write(f'  ldi  r18,0b{int(operando2):08b}\n')
        pilha.append((operando1**operando2))
        file.write(f'''  ldi  r17,0b{int(operando1):08b}
  ldi  r19,0b00000000
  ldi  r21, 0b00000001
  multiplicacao{k}:
    mul r21, r17
    mov r21, r0  ;selecionando a parte baixa da multiplicação
    dec r18  
    brne multiplicacao{k}  
    mov r17, r0\n''')

    else:
      pilha.append(elemento)

  # Atualizar a resposta anterior com o resultado atual
  resposta_anterior = pilha[0]
  return resposta_anterior


nomeArquivo = sys.argv[1]
MEM = 0
nomeArquivo = nomeArquivo.lower()
listaResultado = []

if not nomeArquivo.endswith(".txt"):
  nomeArquivo += ".txt"

#try:
arquivoTxt = open(nomeArquivo, "r")
linhas = arquivoTxt.readlines()
#except:
#  print("Erro ao abrir o arquivo")

memoria = 0
resposta_anterior = 0

with open('pausas.inc', 'w') as arquivo:
  arquivo.write('''pausa_R16_us: 
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
  ret''')

with open('Calculadora.asm', 'w') as file:
  file.write(
      ''';************************************************************************
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
;************************************************************************\n''')
  k = 0
  for i, expressao in enumerate(linhas):
    linhaExpressao = linhas[i]
    print('LINHAS EXPRESSAO: ',linhaExpressao)
    if "RES" in expressao:
      expressaoSemParenteses = expressao.replace("(", "").replace(")", "")
      listaTemp = expressaoSemParenteses.split()
      indice = listaTemp.index('RES')
      linhaResultado = int(listaTemp[indice - 1])

      indiceRespAnterior = i - linhaResultado
      respostaAnterior = linhas[indiceRespAnterior].strip()
      listaTemp[indice] = respostaAnterior
      listaTemp.pop(0)
      concatenalistaTemp = f'({"".join(listaTemp).strip()})'
      linhas[i] = concatenalistaTemp
      expressao = linhas[i]
      expressaoTemp = re.findall(r'\w+|\S', expressao)
      localizando = [
          elemento.strip() for elemento in expressaoTemp if elemento.strip()
      ]

      if localizando[4] in {
          '+', '-', '*', '|', '/', '^', '%'
      } and ("MEM" in localizando[2] or "MEM" in localizando[3]):
        if "MEM" in localizando[2]:
          memoria -= float(localizando[3])
        if "MEM" in localizando[3]:
          memoria -= float(localizando[2])

    resultado = resolve(expressao, memoria, file, k)
    k += 1
    listaResultado.append(resultado)

    if 'MEM)' in expressao and i >= 2:
      memoria = resultado
  file.write('''  clr r16
  clr r19
  out PORTA, r16 ; finaliza saida
  out PORTC, r19 ; finaliza saida
  finalizaSaida:
    nop  ; Nenhuma operação
    rjmp finalizaSaida''')
listaOriginal = open(nomeArquivo, "r").readlines()
for i, resultado in enumerate(listaOriginal):
  print(f'-> {resultado.strip()} = {round(listaResultado[i], 1)}')
arquivoTxt.close()
