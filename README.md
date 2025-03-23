# PROJETO CALCULADORA - FASE 1 - B
### Recomenda-se utilizar o Microchip Studio para carregar o programa com os arquivos 'pausas.inc' e 'Calculadora.asm' no Arduino Mega, após executar o programa em python

  Além de gerar os arquivos 'pausas.inc' e 'Calculadora.asm'. O arquivo .asm apresenta o código assembly para realização das operações no Arduino Mega, o qual utiliza o arquivo .inc com as funcionalidades para realizar um delay entre as operações. 

  Este é um programa desenvolvido em Python para solucionar expressões aritméticas em notação RPN. O programa realia a leitura das expressões em um arquivo txt e realiza o calculo das expressões. As expressões realiza adição, subtração, mutiplicação, divisão real, divisão de inteiros, resto da divisão de inteiros, potenciação e três comandos especiais sendo eles: (N RES), (V MEM) e (MEM). O seu programa executa cada uma das expressões indicadas no ambiente online (python) e gera um arquivo Calculadora.asm, o qual é utilizado para gravar no Arduino Mega para o mesmo apresentar o resultado das operações contidas em todas as linhas do arquivo de entrada.

## Operações em notação RPN
  ->  A e B representam números reais

  a) Adição:+, no formato (A B +);  <br />
  b) Subtração: - no formato (A B -) ;  <br />
  c) Multiplicação: * no formato (A B *);  <br />
  d) Divisão Real: | no formato (A B |);  <br />
  e) Divisão de inteiros: / no formato (A B /);  <br />
  f) Resto da Divisão de Inteiros: % no formato (A B %);  <br />
  g) Potenciação: ^ no formato (A B ^); <br />

### Comandos Especiais
  a) (N RES): devolve o resultado da expressão que está N linhas antes, onde N é um número inteiro não negativo;  <br />
  b) (V MEM): armazena um valor, V, em um espaço de memória chamado de MEM, capaz de armazenar um valor real;  <br />
  c) (MEM): devolve o valor armazenado na memória. Se a memória não tiver sido usada anteriormente devolve o número real zero. Cada arquivo de textos é um escopo de aplicação. <br />

### Observações adicionais de requisitos
  Use o ponto para indicar a vírgula decimal. <br />
  O expoente da operação de potenciação será sempre um inteiro positivo. <br />
  As expressões indicadas podem ser aninhadas para a criação de expressões compostas. <br />
  O programa deverá ser executado recebendo como argumento, na linha de comando, o nome do arquivo de teste. <br />
  Todas as operações serão executadas sobre números reais de meia precisão (16 bits/ IEEE754) <br />

## Executando o Programa
  A execução do programa pode ser feita da seguinte forma:

  --- Replit Shell <br />
    python main.py nomeArquivoTeste <br />

  É necessário substituir 'nomeArquivoTeste' pelo nome do arquivo que deseja solucionar.

## Exemplo de execução
### Arquivo txt
  Nome arquivo txt: 'calculos' <br />
  Conteúdo do arquivo txt:  <br />
  (2 2 +) <br />
  3 (1 2 *) *) <br />
  (16 (2 2 ^) /) <br />
  ((9 5 *) 10 +) <br />
  ((3 2 ^) (2 2 ^) *) <br />
  
### Execução do programa
  --- Replit Shell <br />
  python main.py 'calculos'

### Resultado da execução do programa
  Os resultados das expressões contidas no arquivo 'calculos.txt' serão apresentadas no ambinte online no formato '-> expressão = X', onde 'expressão' é o cálculo realizado e 'X' o resultado do cálculo.

  --- Replit <br />
  -> (2 2 +) = 4.0 <br />
  -> (3 (1 2 *) *) = 6.0 <br />
  -> (16 (2 2 ^) /) = 4.0 <br />
  -> ((9 5 *) 10 +) = 55.0 <br />
  -> ((3 2 ^) (2 2 ^) *) = 36.0 <br />
