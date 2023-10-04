.data
vetor: .word 3,1,2,5,4,2,3,1,2,3,1
.text
la $a0,vetor
li $a1,11
jal selection
j termino
troca: #a0 = base do vetor , a1 = i a2 =j, quero trocar i e j de posição
# *A[i] = $t0, i*4 = $t1, A[i] = $s0, j*4= $t3, *A[j] = $t4, A[j] = $t5
sll $t1,$a1,2 #Multiplico i por 4
add $t0,$a0,$t1 # Pego o endereço de i
lw $s0,0($t0) #Carrego A[i] no $s0

sll $t3,$a2,2 #Multiplico j por 4
add $t4,$a0,$t3 # Pego o endereço de j
lw $t5,0($t4) #Carrego j no $t5

sw $t5,0($t0) # Carrego o valor de j no endereço de i
sw $s0,0($t4) #Carrego o valor de i no endereço de j

jr $ra

selection: #Base do vetor = $a0, tamanho = $a1
 # i = $s0, j = $s1, $ indiceMenor = $s3
 
 add $s0,$zero,$zero  #i=0
 loop1:
	 beq $s0,$a1, exit
    add $s3,$zero,$s0 # indiceMenor = i
	 addi $s1,$s0,1 # j = i+1
	 loop2:
		 beq $s1,$a1, exit2  #se j == tamanho, sai do loop
		 #Primeiro ajeito o indice das variaveis
		 #Segundo dou load nas variáveis
		 sll $t0, $s1,2 # j*4 pra pegar o endereço de base
		 add $t1,$a0,$t0 # Somando a base ao endereço que eu quero
		 lw $t1 ,0($t1) # Carregando A[j] no registrador temporario
		 
		 sll $t3, $s3,2 # indiceMenor *4
		 add $t4,$a0,$t3 #Pego o endereço desejado
		 lw $t4,0($t4) # Carrego o valor de lá
		 # $t5 = A[indice menor] $t2 = A[j]
		 slt $t6,$t4,$t1 #Troquei pra A[indiceMenor] < A[i] será igual a 1
		 bnez $t6,else # Se A[j] < A[IndiceMenor] eu faço o if, se IndiceMenor for maior eu pulo
			 add $s3,$zero,$s1 # Indice menor = j
		 else:
		 addi $s1,$s1,1 # Incremento j
		 j loop2
	 exit2:
	 beq $s0,$s3,else2 # Se i == indiceMenor eu não faço o if
		 addi $sp , $sp, -12
		 #Não preciso salvar a0 porque ele vai ser a base do vetor nos dois procedimentos
		 sw $ra,0($sp)
		 sw $a1,4($sp)
		 sw $s0,8($sp)
		 add $a1, $s0,$zero
		 add $a2, $s3,$zero
		 jal troca
		 lw $ra,0($sp)
		 lw $a1,4($sp)
		 lw $s0,8($sp)
		 addi $sp, $sp, 12
		 #A = troca(A,i,indiceMenor)
	 else2:
	 addi $s0,$s0,1 # Incremento i
	 j loop1
exit:
jr $ra
termino: