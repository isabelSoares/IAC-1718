escreve_ecra					EQU		FFFEh
controlo_ecra 					EQU 	FFFCh
inicializacao_controlo_ecra		EQU		FFFFh
NL								EQU		000Ah
SP_inicial						EQU		FDFFh
mask_compressao					EQU		0000000000000111b
mask_1_comparacao_original		EQU		F000h
int_mask_addr		            EQU		FFFAh
int_mask 		         	    EQU 	1000010001111110b
escreve_LEDs	         	    EQU		FFF8h
estado_inicial_LEDs				EQU		FFFFh
controlo_timer	         	    EQU		FFF7h
intervalo_timer	        	    EQU		FFF6h
escrever_LCD	           		EQU		FFF5h
controlo_LCD	           		EQU		FFF4h
estado_inicial_LCD	         	EQU		1000000000000000b
fim_str_LCD			          	EQU 	':'
display1		          	    EQU		FFF0h
display2		          	    EQU		FFF1h
fim_str_IA						EQU 	'!'
fim_str_limpar_linha			EQU		'.'
fim_str_ganhar					EQU 	'!'
fim_str_perder					EQU		'.'


								ORIG	8000h
sequencia_secreta				WORD	0000h
jogada 							WORD	0000h
resultado 						WORD	0000h
contador						WORD	4
contador2						WORD 	4
contador_X						WORD	0
contador_O 						WORD	0
contador_jogadas				WORD	0
contador_digitos_jog            WORD    4
contador_linhas_ecra			WORD	24
mudar_LEDs						WORD	0
estado_LEDs						WORD	FFFFh
estado_final_LCD				WORD	0
str_LCD							STR 	'PONTUACAO MAX:'
str_IA							STR 	'Pressione o botao IA para jogar!'
mask_gerador_seq_aleatoria		WORD	1000000000010110b
seed							WORD	0000h						;seed inicial do gerador da sequencia aleatoria
mask_1_comparacao				WORD	F000h
mask_2_comparacao				WORD	F000h
temp1							WORD	0
temp2							WORD	0
pontuacao_max					WORD	0
limpar_linha					STR 	'                                                                               .'
cursor_ecra						WORD	0000h
str_ganhar						STR 	'Parabens, ganhou!'
str_perder						STR 	'Game Over.'


;Tabela de interrupcoes
                                ORIG	FE01h
int1				            WORD	botao1
int2				            WORD	botao2
int3				            WORD	botao3
int4				            WORD	botao4
int5				            WORD	botao5
int6				            WORD	botao6

								ORIG 	FE0Ah
int10							WORD	botaoIA

                                ORIG	FE0Fh
timer			    	        WORD	rotina_timer


								ORIG	0000h
								MOV		R7, SP_inicial							;define a posicao inicial da pilha
								MOV 	SP, R7
                                MOV 	R7, int_mask
                                MOV 	M[int_mask_addr], R7
                                MOV 	R7, inicializacao_controlo_ecra
								MOV 	M[controlo_ecra], R7
								JMP		inicio
								
botao1:				            SHL		R2, 4
                                ADD 	R2, 0001h
                                DEC     M[contador_digitos_jog]
                                MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
                                MOV		R5, '1'
								MOV 	M[escreve_ecra], R5
								INC 	M[cursor_ecra]
                                RTI

botao2:				            SHL		R2, 4
                                ADD 	R2, 0002h
                                DEC     M[contador_digitos_jog]
                                MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
                                MOV		R5, '2'
								MOV 	M[escreve_ecra], R5
								INC 	M[cursor_ecra]
                                RTI

botao3:				            SHL		R2, 4
                                ADD 	R2, 0003h
                                DEC     M[contador_digitos_jog]
                                MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
                                MOV		R5, '3'
								MOV 	M[escreve_ecra], R5
								INC 	M[cursor_ecra]
                                RTI

botao4:				            SHL		R2, 4
                                ADD 	R2, 0004h
                                DEC     M[contador_digitos_jog]
                                MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
                                MOV		R5, '4'
								MOV 	M[escreve_ecra], R5
								INC 	M[cursor_ecra]
                                RTI

botao5:			          	    SHL		R2, 4
                                ADD 	R2, 0005h
                                DEC     M[contador_digitos_jog]
                                MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
                                MOV		R5, '5'
								MOV 	M[escreve_ecra], R5
								INC 	M[cursor_ecra]
                                RTI

botao6:		           	      	SHL		R2, 4
                                ADD 	R2, 0006h
                                DEC     M[contador_digitos_jog]
                                MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
                                MOV		R5, '6'
								MOV 	M[escreve_ecra], R5
								INC 	M[cursor_ecra]
                                RTI

botaoIA:						MOV 	R5, R0
								RTI

rotina_timer:		            INC 	M[mudar_LEDs]
								MOV		R7, 5
                                MOV 	M[intervalo_timer], R7
                                MOV		R7, 1
                                MOV		M[controlo_timer], R7
                                RTI


Limpa_ecra:						MOV 	R7, limpar_linha
assim:							CMP 	M[contador_linhas_ecra], R0
								BR.Z	fim_limpa_ecra
								MOV 	R6, fim_str_limpar_linha
								CMP 	R6, M[R7]
								BR.Z	proxima_linha
								MOV 	R6, M[R7]
								MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
								MOV 	M[escreve_ecra], R6
								INC 	R7
								INC 	M[cursor_ecra]
								BR 		assim

proxima_linha:					DEC 	M[contador_linhas_ecra]
								MOV 	R4, M[cursor_ecra]
								ADD 	R4, 0100h
								MOV 	M[cursor_ecra], R4
								JMP 	Limpa_ecra

fim_limpa_ecra:					RET


New_line:						PUSH 	R4
								MOV 	R4, FF00h
								AND 	R4, M[cursor_ecra]
								ADD 	R4, 0100h
								MOV 	M[cursor_ecra], R4
								POP 	R4
								RET


Gerador_seq_aleatoria:			CMP 	M[contador], R0
								BR.Z	fim_gerador_seq_aleatoria
								MOV		R7, M[SP+2]
								MOV 	R6, R7
								AND 	R6, 1h
								CMP 	R6, R0
								BR.NZ	2
								ROR		R7, 1
								BR		2
								XOR		R7, mask_gerador_seq_aleatoria
								ROR		R7, 1
								MOV		R6, 5
								DIV		R7, R6
								INC 	R6
								MOV 	M[SP+2], R7
								MOV		R4, M[SP+3]
								ROL		R4, 4
								ADD		R4, R6
								MOV		M[SP+3], R4
								DEC		M[contador]
								BR		Gerador_seq_aleatoria
fim_gerador_seq_aleatoria:		RETN 	1


Acende_LEDs:					DEC 	M[mudar_LEDs]
								SHR		M[estado_LEDs], 1
								MOV 	R6, M[estado_LEDs]
								MOV		M[escreve_LEDs], R6
								RET


Compressao:						MOV 	R7, M[SP+2]
								MOV 	R5, R0
rodar:							MOV 	R6, mask_compressao
								CMP 	M[contador], R0
								BR.Z	fim_compressao
								ROL 	R7, 4
								AND 	R6, R7
								ADD		R5, R6
								ROL		R5, 3
								DEC 	M[contador]
								JMP 	rodar
fim_compressao:					ROR 	R5, 3
								MOV 	M[SP+3], R5
								RETN	1


Decompressao:					MOV 	R7, M[SP+2]
								ROL 	R7, 4
								MOV 	R5, R0
rodar2:							MOV 	R6, mask_compressao
								CMP 	M[contador], R0
								BR.Z	fim_decompressao
								ROL 	R7, 3
								AND 	R6, R7
								ADD		R5, R6
								ROL		R5, 4
								DEC 	M[contador]
								JMP 	rodar2
fim_decompressao:				ROR 	R5, 4
								MOV 	M[SP+3], R5
								RETN	1

			
Comparacao:						MOV 	R7, M[SP+3]
								PUSH	R0
								PUSH	R7
								CALL 	Decompressao
								MOV 	R4, 4
								MOV		M[contador], R4
								MOV 	R6, M[SP+3]
								PUSH	R0
								PUSH	R6
								CALL 	Decompressao
								POP		R6
								POP		R7
								MOV 	R4, 4
								MOV		M[contador], R4

etiq1:							CMP 	M[contador], R0
								JMP.Z 	bolas

								MOV		R5, M[mask_1_comparacao]
								MOV 	R4, M[mask_1_comparacao]

								AND 	R5, R7
								AND 	R4, R6
								CMP 	R4, R5
								BR.NZ	etiq2
								INC 	M[contador_X]
								SUB 	R7, R5
								SUB 	R6, R4

etiq2:							ROR		M[mask_1_comparacao], 4
								DEC 	M[contador]
								JMP		etiq1


bolas:							MOV 	R5, 4
								MOV 	M[contador], R5
								MOV 	R5, mask_1_comparacao_original
								MOV 	M[mask_1_comparacao], R5

etiq3:							CMP 	M[contador2], R0
								JMP.Z 	fim_comparacao
								CMP 	M[contador], R0
								JMP.Z 	etiq5

								MOV 	R5, M[mask_1_comparacao]
								MOV 	R4, M[mask_2_comparacao]
								AND		R5, R7
								AND 	R4, R6
								CMP 	R5, R0
								BR.Z	etiq5
								CMP 	R4, R0
								BR.Z	etiq4

								MOV 	M[temp1], R4
								MOV 	M[temp2], R5
								PUSH	R0
								PUSH 	R4
								CALL	aux_comparacao
								POP		R4
								PUSH 	R0
								PUSH	R5
								CALL	aux_comparacao
								POP		R5

								CMP 	R4, R5
								JMP.NZ	etiq4
								
								INC 	M[contador_O]
								SUB 	R7, M[temp2]
								SUB 	R6, M[temp1]

etiq4:							ROR 	M[mask_2_comparacao], 4
								DEC 	M[contador]
								JMP 	etiq3

etiq5:							MOV 	R5, 4
								MOV 	M[contador], R5
								DEC 	M[contador2]
								ROR 	M[mask_2_comparacao], 4
								ROR 	M[mask_1_comparacao], 4
								JMP 	etiq3

fim_comparacao:					RETN	2

aux_comparacao:					PUSH 	R4
ola:							MOV 	R4, M[SP+3]
								AND 	R4, 000Fh
								CMP 	R4, R0
								BR.NZ	3
								ROR 	M[SP+3], 4
								JMP 	ola
								MOV 	M[SP+4], R4
								POP		R4
								RETN	1


Resultado:						MOV 	R7, M[SP+3]									;determina o resultado, codificado-o
								MOV		R6, M[SP+2]									;da seguinte forma:
								SHLA	R7, 4										;ultimo digito - numero de Os
								ADD 	R3, R7										;penultimo digito - numero de Xs
								ADD		R3, R6
								MOV 	M[resultado], R3
								RETN	2


Escreve_resultado:				MOV 	R7, M[SP+2]									;funcao que escreve o resultado
								MOV		R6, 16										;da comparacao da jogada atual
								DIV		R7, R6										;com a sequencia secreta
								MOV 	R5, 4h
								SUB		R5, R7
								SUB		R5, R6
escreve_X:						CMP 	R7, R0
								BR.Z	escreve_O
								MOV 	R4, M[cursor_ecra]
								MOV 	M[controlo_ecra], R4
								MOV		R4, 'X'
								MOV		M[escreve_ecra], R4
								INC 	M[cursor_ecra]
								DEC		R7
								BR		escreve_X
escreve_O:						CMP 	R6, R0
								BR.Z	escreve_traco
								MOV 	R4, M[cursor_ecra]
								MOV 	M[controlo_ecra], R4
								MOV		R4, 'O'
								MOV		M[escreve_ecra], R4
								INC 	M[cursor_ecra]
								DEC		R6
								BR		escreve_O
escreve_traco:					CMP 	R5, R0
								BR.Z	fim_escreve_resultado
								MOV 	R4, M[cursor_ecra]
								MOV 	M[controlo_ecra], R4
								MOV		R4, '-'
								MOV		M[escreve_ecra], R4
								INC 	M[cursor_ecra]
								DEC		R5
								BR		escreve_traco
fim_escreve_resultado:			RETN	1


Game_over:						CALL 	New_line
								MOV 	R7, str_perder
								MOV 	R4, fim_str_perder
ir:								CMP 	R4, M[R7]
								BR.Z 	fim_game_over
								MOV 	R6, M[R7]
								MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
								MOV 	M[escreve_ecra], R6
								INC 	R7
								INC		M[cursor_ecra]
								JMP 	ir
fim_game_over:					CALL 	New_line
								RET

Ganhou:							CALL 	New_line
								MOV 	R7, str_ganhar
								MOV 	R4, fim_str_ganhar
vai:							CMP 	R4, M[R7]
								BR.Z 	fim_ganhou
								MOV 	R6, M[R7]
								MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
								MOV 	M[escreve_ecra], R6
								INC 	R7
								INC		M[cursor_ecra]
								JMP 	vai
fim_ganhou:						CALL 	New_line
								RET





inicio:							MOV 	R3, R0
								
								MOV 	R7, str_IA
mais:							MOV 	R6, M[R7]
								MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
								MOV 	M[escreve_ecra], R6
								INC 	R7
								INC		M[cursor_ecra]
								CMP 	R6, fim_str_IA
								BR.NZ	mais
								CALL 	New_line

								ENI
								MOV 	R5, 1
ciclo:							CMP 	R5, R0
								BR.Z	segue
								INC 	M[seed]
								BR 		ciclo

segue:							DSI
								MOV 	M[cursor_ecra], R0
								MOV 	R7, 24
								MOV 	M[contador_linhas_ecra], R7
								CALL 	Limpa_ecra
								MOV 	M[cursor_ecra], R0

			                    PUSH	R0
								PUSH	M[seed]
								CALL	Gerador_seq_aleatoria
								POP		R1
								MOV 	R7, 4
								MOV		M[contador], R7
								PUSH 	R0
								PUSH 	R1
								CALL 	Compressao
								POP 	R1
								MOV 	M[sequencia_secreta], R1

comecar:						MOV 	R7, estado_inicial_LCD
								MOV 	R5, str_LCD
escreve_LCD:					MOV 	R6, M[R5]
								MOV 	M[controlo_LCD], R7
								MOV		M[escrever_LCD], R6
								CMP		R6, fim_str_LCD
								BR.Z	ciclo_jogo
								INC 	R5
								INC 	R7
								MOV 	M[estado_final_LCD], R7
								JMP 	escreve_LCD

ciclo_jogo:						INC		M[contador_jogadas]
								MOV 	R7, 13
								CMP 	M[contador_jogadas], R7
								JMP.Z	perder

continua:						ENI
								MOV 	R6, estado_inicial_LEDs
								MOV 	M[estado_LEDs], R6
								MOV		M[escreve_LEDs], R6
	                            MOV		R7, 5
                                MOV 	M[intervalo_timer], R7
								MOV		R7, 1
		                        MOV		M[controlo_timer], R7
                              		
pois:                        	CMP 	M[mudar_LEDs], R0
								CALL.NZ Acende_LEDs
								CMP 	M[contador_digitos_jog], R0
								JMP.Z	prosseguir
								CMP 	M[estado_LEDs], R0
								JMP.Z 	perder
								BR 		pois

prosseguir:						MOV		R7, 0
		                        MOV		M[controlo_timer], R7
		                        DSI
		                        MOV 	R6, estado_inicial_LEDs
								MOV 	M[estado_LEDs], R6

								MOV 	R7, M[contador_jogadas]
								MOV 	R6, 10

								CMP 	R7, R6
								BR.NN	usa_2_displays
								MOV 	M[display1], R7
								JMP 	continua_2
usa_2_displays:					SUB 	R7, 10
								MOV		M[display1], R7
								MOV 	R7, 1
								MOV 	M[display2], R7

continua_2:						MOV 	R7, 4
								MOV		M[contador], R7
								PUSH	R0
								PUSH 	R2
								CALL 	Compressao
								POP 	R2
								MOV 	M[jogada], R2

								MOV 	R7, 4
								MOV		M[contador], R7
								PUSH	R1
								PUSH	R2
								CALL	Comparacao

								MOV 	R7, 4
								MOV		M[contador], R7
								PUSH	M[contador_X]
								PUSH	M[contador_O]
								CALL	Resultado

								MOV		R6, 4
								MOV 	M[contador], R6

								MOV 	R5, M[cursor_ecra]
								MOV 	M[controlo_ecra], R5
								MOV 	R6, ' '
								MOV 	M[escreve_ecra], R6
								INC		M[cursor_ecra]
								PUSH	R3
								CALL	Escreve_resultado
								CALL 	New_line

								MOV 	M[contador_X], R0
								MOV 	M[contador_O], R0
								MOV 	R7, 4
								MOV		M[contador], R7
								MOV     M[contador_digitos_jog], R7

								CMP 	R3, 0040h
								JMP.Z	ganhar
								JMP		ciclo_jogo

ganhar:							CALL	Ganhou

								MOV 	R7, M[contador_jogadas]
								CMP 	R7, M[pontuacao_max]
								JMP.NN 	inicio

								MOV 	R7, M[estado_final_LCD]
								INC 	R7
								MOV 	M[controlo_LCD], R7
								MOV 	R6, M[contador_jogadas]
								MOV 	R5, 10
								CMP 	R6, R5
								BR.NN	tem_2_digitos
								ADD 	R6, '0'
								MOV		M[escrever_LCD], R6
								JMP		inicio
tem_2_digitos:					MOV		R4, '1'
								MOV 	M[controlo_LCD], R7
								MOV		M[escrever_LCD], R4
								INC 	R7
								MOV 	M[controlo_LCD], R7
								SUB 	R6, 10
								ADD 	R6, '0'
								MOV		M[escrever_LCD], R6
								JMP		inicio


perder:							CALL	Game_over
								JMP		inicio