.data
	vetor: .word 1222,0,96,8,7,23,44,2,52,123,345,2345,456,234,11,223,59
	tam: .word 17

.text

j start


bubblesort:
subi $sp,$sp,12
sw $s0,0($sp) # i
sw $s1,4($sp) # troca
sw $s2,8($sp) # tamanho

add $s2,$zero,$a1 #tamanho = argumento em a1
do:

	add $s1,$zero,$zero #troca = false
		
	# calculando tam-1
	subi $s2,$s2,1 
	#i = o
	add $s0,$zero,$zero
	for:
		slt $t0,$s0,$s2
		beqz $t0,ForExit
		
		#carregar a[i] em t1
		#carregar a[i+1] em t2
		#deixar endereço  a[i] em t0 
		
		sll $t0,$s0,2
		add $t0,$a0,$t0
		
		lw $t2,4($t0)
		lw $t1,0($t0)
		
		# if...
		slt $t3,$t2,$t1  # i+1 < i ?
		beqz $t3,else
		# troca
 		sw $t2,0($t0) 
 		sw $t1,4($t0)
		
		addi $s1,$s1,1 #troca = true
		
		else:
		
		addi $s0,$s0,1
		j for
		
	ForExit:
	beqz $s1, whileExit
	j do
whileExit:
		
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
addi $sp,$sp,12	

jr $ra



start:

	#carregar endereço base em a0 e tamanho em a1
la $a0,vetor
lw $a1,tam
	
jal bubblesort
	
