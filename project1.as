IO						EQU		FFFEh
div 					EQU		10
	
						ORIG	8000h
sequencia				WORD	1234
jogada_atual			WORD	1111
digitos_sequencia		TAB		4
digitos_jogada_atual	TAB		4
endereco_tabela			WORD	0000h
contador				WORD	0

						ORIG	0000h
						BR		Inicio
	
Fragmentacao:			MOV 	R6, M[SP+2]
						MOV		R7, M[div]
						DIV		R6, R7
						PUSH 	R6
						PUSH	R7
						CMP		R6, R0
						BR.NZ	Fragmentacao
						CALL	func
						RET
						
func					CMP		M[contador], 0
						BR.Z	qwerty
						MOV 	R3, M[SP+1]
						MOV 	M[endereco_tabela], R3
						RET

Inicio:					MOV		R1, M[sequencia]
						MOV		R2, M[jogada_atual]
						PUSH	R1
						MOV 	R3, digitos_sequencia
						MOV 	M[endereco_tabela], R3
						CALL	Fragmentacao
						PUSH	R2
						CALL	Fragmentacao
				