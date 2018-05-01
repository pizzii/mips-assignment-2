.data 
	message_title:     	 .asciiz "Program to calculate quadratic equation \n"
	message1:	 	 .asciiz "\nEnter value for a\n "
	message2:		 .asciiz "Enter value for b\n "
	message3:		 .asciiz "Enter value for c\n "
	neg_one:		.float -1.0
	number1:		.float 4.0
	number2:		.float 2.0
	complex_root:		.asciiz  "complex root"
	answer:			.asciiz "the values for x =\n"
	space:			.asciiz ","
	


.text 
	 	li $v0, 4 #title of programe
		la $a0, message_title
		syscall
	main:
	
		lwc1 $f20, neg_one
		lwc1 $f18, number1
		lwc1 $f16, number2
	
		
	
  		li $v0,4 #value for a
  		la $a0,message1
  		syscall
  	
  		li $v0,6
  		syscall
  		mov.s $f2,$f0
  	
  	
  		li $v0,4 #value for b
  		la $a0,message2
  		syscall
  	
  		li $v0,6
  		syscall
  		mov.s $f4,$f0
  	
  	
  		li $v0,4 #value for c
  		la $a0,message3
  		syscall
  	
  		li $v0,6
  		syscall
  		mov.s $f6,$f0
  	
	
		jal calculate
	
	#print answers
		li $v0,4
		la $a0, answer
		syscall
	
		li $v0,2
		mov.s $f12,$f25
		syscall
	
		li $v0,4
		la $a0,space
		syscall
	
		li $v0,2
		mov.s $f12,$f28
		syscall
	
	b exit
	
	calculate:
		mul.s $f14,$f4,$f4 #bb
		mul.s $f22,$f2,$f6 #ac 
		mul.s $f18,$f18,$f22 #4ac
		sub.s $f24,$f14,$f18 #bb-4ac
		mfc1 $t1,$f24
		bltz $t1,error
		sqrt.s $f26,$f24
		mul.s $f20,$f4,$f20 #-b
		mul.s $f16,$f2,$f16 #2a
		add.s $f21,$f20,$f26 #-b+sqrt(bb-4ac)
		sub.s $f23,$f20,$f26 #-b-sqrt(bb-4ac)
		div.s $f25,$f21,$f16 #-b+sqrt(bb-4ac)/2a
		div.s $f28,$f23,$f16 #-b-sqrt(bb-4ac)/2a
	jr $ra
	error:
		li $v0,4
		la $a0,complex_root
		syscall
		j main
		
	
	exit:
		li $v0,10
		syscall
