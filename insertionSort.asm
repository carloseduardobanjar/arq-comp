.data
	vec: .word 100, 9, 8, 7, 6, 500, 15, 61, 30, 8
	vecsz:  .word 10
.text

la $a0, vec
lw $a1, vecsz
insertion:
	addi $s0, $zero, 1
	
	for:
		slt $t1, $s0, $a1
		addi $t0, $zero, 1
		bne $t0, $t1, endfor
	
		sll $t2, $s0, 2
		add $t2, $a0, $t2
	
		lw $s2, 0($t2) # temp = A[i]
	
		addi $s1, $s0, -1 # j = j-1
	
		while:
			slt $t1, $s1, $zero
			beq $t1, $t0, endwhile
		
			sll $t3, $s1, 2
			add $t3, $t3, $a0
			lw $t3, 0($t3) # A[j]
			slt $t2, $s2, $t3
			bne $t2, $t0, endwhile
		
			addi $t1, $s1, 1
			sll $t1, $t1, 2
			add $t1, $t1, $a0 # A[j+1]
		
			sw $t3, 0($t1) # A[j+1] = A[j]
		
			addi $s1, $s1, -1 # j = j-1
			j while		
		endwhile:
	
		addi $t1, $s1, 1
		sll $t1, $t1, 2
		add $t1, $t1, $a0
		sw $s2, 0($t1) # A[j+1] = temp
	
		addi $s0, $s0, 1
		j for
	endfor:
	
	
