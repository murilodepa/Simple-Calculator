TITLE Calculadora

.MODEL SMALL
.STACK 100H
.DATA
contador dw 0
valor1 dw 0
multi1 dw 1
valor2 dw 0
multi2 dw 1
cont dw 0
sinal dw 0
cont2 dw 0
SINAL1 dw 43
SINAL2 dw 43
SINAL3 dw 0
res dw 0
x dw 0
y DW 0
cont3 dw 0
cont16 dw 0
cont2x dw 0

message db "erro divisao por zero $"
message2 db "overflow$"
message3 db "                        CALCULADORA",0dh,0ah
 db"Para utiliza-la, digite (operando1) sinal (operando2) [enter]",0dh,0ah
 db" Exemplo: 2-4 [enter] ; -2+-2 [enter] ",0dh,0ah
 db"                                ",0dh, 0ah
 db"                          Operacoes ",0dh,0ah
 db"                                ",0dh, 0ah
 db"+(soma); Ex:2+4 [enter]",0dh,0ah
 db"-(subtracao); ex -2-2 [enter]",0dh,0ah
 db"*(multiplicacao); ex -4*-2 [enter]",0dh,0ah
 db"%(divisao); 10%2 [enter]",0dh,0ah
 db".(and); 10.10 [enter]",0dh,0ah
 db"u(or); 10u10 [enter]",0dh,0ah
 db"n(not); 10n [enter]",0dh,0ah
 db"!(Xor); 15!10 [enter]",0dh,0ah
 db"^(expoente); 2^3 [enter]",0dh,0ah
 db"s(multiplicar por potencia de 2 Ex:10s4 [enter];)",0dh,0ah
 db"t(dividir por potencia de 2 Ex:32t5 [enter])",0dh,0ah
 db"v(multiplicar por potencia de 10 Ex:10v4 [enter])",0dh,0ah
 db"x(dividir por potencia de 10 Ex:10000x4 [enter])",0dh,0ah
 db"$"
 message4 db "Deseja continuar?$"
message5 db "Ponto Flutuante$"
message6 db "deseja continuar (0)ou (1)$"
 
.CODE

.STARTUP 
retor9:
mov ax,0
mov cx,0
mov dx,0
mov bx,0
mov valor1,0
mov valor2,0
mov contador,0
mov multi1,1
mov multi2,1
mov cont,0
mov sinal,0
mov cont2,0
mov sinal1,43
mov sinal2,43
mov sinal3,0
mov res,0
mov x,0
mov y,0
mov cont3,0
mov cont16,0
mov cont2x,0


MOV AH,09H
MOV DX, offset message3
INT 21h 

mov dx,0
mov ax,0

mov bx,1

loop_01: 
mov dx, 0
MOV AH,1
INT 21H

mov dh,0
MOV dl, al
cmp dx,57
jg fim
cmp dx,48
jl fim 
mov x, 1
sub dx,48
push dx
add cont2,bx
jmp loop_01

loop3: 
pop dx
mov y, 0
mov ax,multi1
mul dx
add valor1,ax
mov ax,multi1
mov dx,10
mul dx
mov multi1,ax
sub cont2,bx
cmp cont2,0
je loop_02
jmp loop3

retor8:
jmp retor9

fim:
mov sinal,DX
cmp dx, 45
JE L1
CMP DX, 43
JE L1
jmp loop3

L1: 
cmp x, 1
je Loop3
MOV SINAL1, DX 
mov x, 1
jmp loop_01

L2:
CMP y, 1
JE loop_02
MOV SINAL2, DX
mov y, 1

loop_02:
MOV x, 0
mov dx, 0
MOV AH,1
INT 21H
mov dh,0
MOV dl, al
CMP DX, 45
JE L2
CMP DX, 43
JE L2
cmp dx,13
je operacao
mov y, 1
sub dx,48
push dx
add cont2,bx
jmp loop_02

teste:
pop dx
mov ax,multi2
mul dx
add valor2,ax
mov ax,multi2
mov dx,10
mul dx
mov multi2,ax
sub cont2,bx
cmp cont2,0
je calculo
jmp teste													

operacao: 
mov dh,0
mov dx, 61
mov ah,2
int 21h
mov dh,0
mov dx, 32
mov ah,2
int 21h

jmp teste

calculo:
mov ax,valor1
mov cx,1
cmp sinal,45
je subtracaot1
cmp sinal,43
je somateste
cmp sinal,42
je multi10
cmp sinal,37
je divisao
cmp sinal,46
je andet
cmp sinal,117
je ou1
cmp sinal,33
je xore1
cmp sinal,110
je nao1
cmp sinal,104
je para161
cmp sinal,98
je para21;
cmp sinal, 94
je pot1
cmp sinal,115
je multiby21
cmp sinal,116
je divby21
cmp sinal,118
je multyby10
cmp sinal,120
je divby10

retor7:
jmp retor8

subtracaot1:
jmp subtracaot

subtracaot:
jmp subtracaob

somateste:
jmp soma

multi10:
jmp multi

andet:
jmp ande

ou1:
jmp ou2

divisao:
mov bx,valor2
cmp bx,0
je msgerro12
div bx
mov res, ax
jmp printar1

para161:
jmp para16

xore1:
jmp xore

nao1:
jmp nao

pot1:
jmp pot

para21:
jmp para2

multiby21:
jmp multiby2

divby21:
jmp divby2

retor6:
jmp retor7

multyby10:
mov ax,1
mov bx,10
multyby10t:
mul bx
sub valor2,cx
cmp valor2,0
je multyby10c
jmp multyby10t

msgerro12:
jmp msgerro

multyby10c:
mov bx,valor1
mul bx
mov res,ax
jmp printar1

divby10c:
mov dx,0
mov bx,ax
mov ax,valor1
div bx
mov res,ax
jmp printar1

divby10:
mov ax,1
mov bx,10
divby10t:
mul bx
sub valor2,1
cmp valor2,0
je divby10c
jmp divby10t

ou2:
jmp ou

para16:
mov dx,0
mov bx,16
div bx
cmp dx,9
jg subtr1
noe:
push dx
add cont16,cx
cmp ax,0
jne para16
jmp print16

multiby2:
mov ax,1
mov bx,2
multyby2t:
mul bx
sub valor2,1
cmp valor2,0
je multyby2c
jmp multyby2t

divby2:
mov ax,1
mov bx,2
divby2t:
mul bx
sub valor2,1
cmp valor2,0
je divby2c
jmp divby2t

subtr1:
jmp subtr

divby2c:
mov dx,0
mov bx,ax
mov ax,valor1
div bx
mov res,ax
jmp printar1

retor5:
jmp retor6

para2:
mov dx,0
mov bx,2
div bx
push dx
add cont16,cx
cmp ax,0
jne para2
jmp print16

multyby2c:
mov bx,valor1
mul bx
mov res,ax
jmp printar1

msgerro:
mov ah, 09h
mov dx, offset message
int 21h
jmp encerar

subtracaob:
jmp subtracao

print16:
mov dh,0
pop dx
add dx,48
mov ah,2
int 21h
sub cont16,cx
cmp cont16,0
jne print16
jmp encerar

subtr:
add dx,7
jmp noe

nao:
not ax
mov res,ax
jmp print

xore:
cmp sinal1, 45
je i5
xore2:
cmp sinal2, 45
je i6
xore3:
xor ax,valor2
mov res,ax
jmp print

i5:
neg ax
mov valor1, ax
jmp xore2
i6:
mov ax, valor2
neg ax
mov valor2, ax
mov ax, valor1
jmp xore3

ou:
cmp sinal1, 45
je i3
ou5:
cmp sinal2, 45
je i4
ou6:
or ax,valor2
mov res,ax
jmp print

i3:
neg ax
mov valor1, ax
jmp ou5
i4:
mov ax, valor2
neg ax
mov valor2, ax
mov ax, valor1
jmp ou6

retor4:
jmp retor5

ande:
cmp sinal1, 45
je i1
ande2:
cmp sinal2, 45
je i2
ande3:
and ax,valor2
mov res,ax
jmp print

i1:
neg ax
mov valor1, ax
jmp ande2
i2:
mov ax, valor2
neg ax
mov valor2, ax
mov ax, valor1
jmp ande3


subtracao:
cmp sinal1, 45
je soma2

subtracao1:
cmp sinal2, 45
je soma1
subs3:
mov bx,valor2
sub ax,valor2
mov res, ax
cmp bx, valor1
jl printar011
neg res
;mov ax, 1
;add res, ax
mov ax, valor1
cmp ax, valor2
je printx
mov ax, res
mov dh,0
mov dx,45
mov ah,2
int 21h
jmp printar0

soma2:
cmp sinal2, 45
je subs3
jmp soma1

soma:
cmp sinal1, 45
je subtracao1

cmp sinal2, 45
je subs3

soma1:
add ax,valor2
jc msgerro2
mov res, ax
jmp printar0

printx:
jmp print01

printar011:
jmp printar0

multi:
mov dx,0
mov bx,valor2
mul bx
cmp dx,0
jne msgerro2
mov res, ax
jmp printar1

msgerro2:
mov ah, 09h
mov dx, offset message2
int 21h
jmp encerar

retor3:
jmp retor4

impr:
mov dh, 0
mov dx, 49
mov ah, 2
int 21h
jmp encerar

impr2:
mov ah, 09h
mov dx, offset message5
int 21h
jmp encerar

impr3:
mov ax, valor1
cmp sinal1, 43
je k1
mov dh, 0
mov dx, 49
mov ah, 2
int 21h
jmp k1


pot:
cmp sinal2, 45
je impr2
cmp valor2, 0
je impr
cmp valor2, 1
je impr3
mov bx, valor2
sub bx, 1
mov cont3, bx
mov ax, valor1
mov bx, valor1

pot2:
mul bx
cmp dx, 0
JNE msgerro2
mov res, ax
mov ax, cont3
sub ax, 1
mov cont3, ax
mov ax, res 
cmp cont3, 0
JNE pot2
jmp prints


print01:
mov ax, res
jmp print

k1:
jmp print

prints:
cmp sinal1, 43
je print7
mov dx,0
mov ax, valor2
mov bx, 2
div bx
push dx 

pop dx
mov ax, res
cmp dx, 0
je print7
mov ax, res
mov dl, 0
mov dh, 0
mov dx, 45
mov ah, 2
int 21h
mov ax, res
jmp print7

;sinais para a adição e subtração
printar0:
CMP SINAL1, 43
JE teste1
CMP SINAL1, 45
JE teste2

printar2:

CMP SINAL2, 43
JE teste3
CMP SINAL2, 45
JE printar3

retor2:
jmp retor3

teste1: 
mov ax, 1
ADD ax, SINAL3 
mov SINAL3, ax
JMP printar2

teste2:
mov SINAL3, 0
JMP printar2

teste3:
mov ax, 1
ADD ax, SINAL3
mov SINAL3, ax

printar3:
mov ax, res
cmp SINAL3, 0
JE print00
cmp SINAL3, 1
JE printar01
cmp SINAL3, 2
jmp print

print7:
jmp print

;sinais para a adição e subtração

print00:
mov dl, 0
mov dh, 0
mov dx, 45
mov ah, 2
int 21h
mov ax, res
JMP print

printar01:
mov ax, valor1
cmp ax, valor2
jg imprime
cmp ax, valor2
je imprime
cmp SINAL, 45
je imprime1
imprime2:
mov ax, res
JMP print


imprime1:
cmp sinal2, 45
jmp imprime2
mov dl, 0
mov dx, 45
mov ah, 2
int 21h
mov ax, res
JMP print


imprime:
mov dl, 0
mov dx, SINAL1
mov ah, 2
int 21h
mov ax, res
JMP print
;sinais para a adição e subtração


;sinais para a multiplicacao e divisao
printar1:
CMP SINAL1, 43
JE teste4
CMP SINAL1, 45
JE teste5

printar4:

CMP SINAL2, 43
JE teste6
CMP SINAL2, 45
JE printar5

retor:
jmp retor2

teste4: 
mov ax, 1
ADD ax, SINAL3 
mov SINAL3, ax
JMP printar4

teste5:
mov SINAL3, 0
JMP printar4

teste6:
mov ax, 1
ADD ax, SINAL3
mov SINAL3, ax

printar5:
mov ax, res
cmp SINAL3, 0
JE print
cmp SINAL3, 2
JE print
mov dl, 0
mov dx, 45
mov ah, 2
int 21h
mov ax, res
mov SINAL3, 0
;sinais para a multiplicacao e divisao

print: 
MOV SINAL3, 0
mov dx,0
mov bx,10
div bx
push dx
add cont,cx
cmp ax,0
je printar
jmp print

printar:
pop dx
add dx, 48
sub cont, 1
mov ah,2
int 21h
mov cx, cont
cmp cx,0
je encerar
jmp printar


encerar:
MOV AH,2
MOV DL,0DH 
INT 21H
MOV DL,0AH 
INT 21H 
MOV AH,09H
MOV DX, offset message6
INT 21h
mov al,0
mov ah,1
int 21h
cmp al,48
je finalizar
jmp retor 

finalizar:
MOV AH, 4CH
INT 21H

end