# Programm zur Berchnung des BinominalKoeffizienten (n über k) = n! / (n-k)! * k!

# Bedingung n >= k | n, k Element N

.text
	lw	$t1,	n
	lw	$t2,	k
	lw	$t6,	one		        #Nenner
	lw	$t7, 	one 		      #Divisor
	
	beqz	$t2, 	isOne		    #Sonderfall k = 0
	sub 	$t3, 	$t1,	$t2	  #$3 = (n-k)
	beqz	$t3,	isOne		    #Sonderfall n = k
	bgt	  $t2, 	$t3, 	m1   	#Falls (n-k) groesser k
	move 	$t4, 	$t3	      	#$4 ist topvariable für n! (n!/(n-k)!)
	move 	$t5, 	$t2		      #$5 ist Fakultät durch die geteilt wird
	j	    fakdiv				
	
m1:	move 	$t4,	$t2		    #Äquivalent vertauscht
	  move	$t5,	$t3

fakdiv:					          #Berechnung des Divisors
   	mul	  $t7,	$t7,	$t5
   	subi 	$t5,	$t5,	0x1
	  bgtz	$t5,	fakdiv
	
faknen:					          #Berechnung des Nenners			
	  mul 	$t6,	$t6, 	$t1
	  subi	$t1,	$t1,	0x1
	  bgt 	$t1,	$t4,	faknen
	
	  div	$t9, 	$t6,	$t7	  #Berechnung des Ergebnises	

end:
	  j	end		            	#Programmende
	
isOne:	
    lw	$t9,	one		      #Ergebnis ist 1
	  j	end	

.data
n:	.word	  0x0000000B		#Variable
k:	.word	  0x00000007		#Variable	
		
one:  .word	0x00000001		#Konstante
