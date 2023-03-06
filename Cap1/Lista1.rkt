#lang sicp
; Exercício 1.1

10 ; 10

(+ 5 3 4) ; 12

(- 9 1) ; 8

(/ 6 2) ; 3

(+ (* 2 4) (- 4 6)) ; 6

(define a 3) ; Nada, mas define a = 3

(define b (+ a 1)) ; Nada, mas define b = a + 1 = 4

(+ a b (* a b)) ; 19

(= a b) ; #f

(if (and (> b a) (< b (* a b))) 
    b
    a) ; b = 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)) ; 16

(+ 2 (if (> b a) b a)) ; 6

(* (cond ((> a b) a )
         ((< a b) b )
         (else -1))
   (+ a 1)) ; 16

; Exercício 1.2
; A definição de notação prefixa está na página 6, mas basicamente quer dizer
; que devemos transcrever formula utilizando a notação de código.

; Talvez eu tenha roubado um pouquinho nessa solução abaixo
(/ (- (+ 5 4 2) (- 3 (+ 6 (/ 4 5)))) (* 3 (- 6 2) (- 2 7)))

; O mais próximo seria isso
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))  (* 3 (- 6 2) (- 2 7)))

; Exercício 1.3
(define (square x) (* x x))
(define (sum-of-squares x y) (+ (square x) (square y)))

(define (squared-largest a b c)
  (cond
    ((> a b) (if (> b c) (sum-of-squares a b) (sum-of-squares a c)))
    ((> a c) (sum-of-squares a b))
    (else (sum-of-squares b c))))

(squared-largest 1 2 3) ; 13
(squared-largest 1 2 2) ; 8  
(squared-largest 1 2 1) ; 5
(squared-largest 1 1 1) ; 2

; Exercício 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; No caso mais simples, suponha a=b=1. Primeiro, a condição b > 0 seria avaliada.
; Como é verdadeira, o resultado é +, o que leva a próxima expressão (+ a b) =>
; (+ 1 1) = (1 + 1) = 2.
(a-plus-abs-b 1 1) ; 2

; Suponha agora a =1 e b = -1. A condição b > 0 é avaliada e é falsa, resultando
; em -, o que leva a próxima expressão (- a b) =>
; (- 1 -1) = (1 - (-1)) = (1 + 1) = 2.
(a-plus-abs-b 1 -1) ; 2

; Basicamente, a e b são somados e quando b é negativo, seu valor é multiplicado
; por -1.


; Exercício 1.5
(define (p) (p)) ; Uma função que se chama.

(define (test x y)
  (if (= x 0)
      0
      y))

; Nesse caso a execução nunca é interrompida, pois os argumentos da função são
; avaliados antes da execução do corpo da função. Por exemplo, 0 é avaliado
; e só retorna 0. Por conseguinte, (p) é avaliado e o seu resultado é retornar
; (p), o que torna o código interminável.

; Isso significa que essa versão de Scheme utiliza uma versão aplicativa:
; parametros de função são avaliadas antes da execução da função. Diferente
; da ordem normativa, que expande os termos e depois os reduz.
(test 0 (p))