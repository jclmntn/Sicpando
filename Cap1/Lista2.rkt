#lang sicp
; Definindo funções necessárias para o exercício

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; Exercício 1.6
; Com essa definição, temos um looping infinito. Ou seja, new-if nunca realiza a
; condição de parada.
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;(define (sqrt-iter guess x)
;  (new-if (good-enough? guess x)
;      guess
;      (sqrt-iter (improve guess x)
;                 x)))
;
;(define (sqrt x)
;  (sqrt-iter 1.0 x))

; Observe que quando fazemos essa condição, ocorre o esperado. O resultado é #t.
(new-if #t #t #f)

; Por outro lado, quando o predicado é #f, o resultado será #f. 
(new-if #f #t #f)

; No caso base de good-enough, o resultado está consistente.
(new-if (good-enough? 1. 1) #t #f)

; O problema começa quando substituímos a else-clause por uma função recursiva...
;(new-if (good-enough? 1. 1) #t (sqrt-iter (improve 1. 1) 1))
; E ele existe por causa da ordem aplicativa! new-if é uma função e essa regra é
; aplicada em funções. Antes de aplicar new-if nos argumentos, os argumentos são
; avaliados. Porque new-if faz parte dessa estrutura, sqrt-iter será avaliada
; inúmeras vezes. if é uma forma especial e, por essa razão, possui regras
; específicas para sua avaliação.


; Exercício 1.7
; Vamos começar com raízes de pequenos números, primeiro 1e-02
(square (sqrt 0.01)) ; Ok!


; E 1e-03?
(square (sqrt 0.001)) ; Próximo, mas está quase ultrapassando!

; 1e-04?
(square (sqrt 0.0001)) ; Aqui já errou o resultado por uma casa decimal.

; 1e-05?
(square (sqrt 0.00001)) ; Outro erro grosseiro, aqui deu 0.009832.

; E para números grandes?
; A partir de 1e7 já começamos a observar resultados estranhos.
(square (sqrt 10000000))

; Em 1e13, a função não dá resultado algum! Fica rodando eternamente.
;(square (sqrt 10000000000000))

; Vamos implementar a procedure sugerida pelo autor: ao invés de verificar se a
; diferença entre o quadrado do resultado e o valor do qualqueremos a raíz é su-
; ficientemente pequeno, vamos verificar se a diferença entre o resultado corren-
; te e o anterior são suficientemente pequenos.

(define (good-enough?-v2 current-guess last-guess)
  (< (abs (- current-guess last-guess)) 0.001))

(define (sqrt-iter-v2 current-guess last-guess x)
              (if (good-enough?-v2 current-guess last-guess)
                  current-guess
                  (sqrt-iter-v2 (improve current-guess x) current-guess x)))

; current-guess não pode ser igual a last-guess, caso contrário a execução é in-
; terrompida sem que um resultado relevante seja obtido. No exemplo abaixo, é vi-
; sível que o método funciona, mas o resíduo preocupa um pouco.
(define (sqrt-v2 x)
  (sqrt-iter-v2 2 1 x))

(square (sqrt 100))
(square (sqrt-v2 100))

; Vamos ver como ele se comporta com 1e-04?
(square (sqrt 0.0001))
(square (sqrt-v2 0.0001)) ; Mais preciso!

; E 1-e05?
(square (sqrt 0.00001))
(square (sqrt-v2 0.00001)) ; Bem melhor!

; E para números grandes?
;(square (sqrt-v2 10000000000000)) Continua rodando pra sempre!


; Exercício 1.8
; Vamos implementar uma procedure para funções cúbicas.
(define (cube x)
  (* x x x))

(define (average-cube x y)
  (/ (+ x y) 3))  

(define (improve-cube guess x)
  (average-cube (* 2 guess) (/ x (square guess))))

(define (cube-root-iter current-guess last-guess x)
  (if (good-enough?-v2 current-guess last-guess) ; Melhoria do exercício anterior introduzida!
      current-guess
      (cube-root-iter (improve-cube current-guess x)
                 current-guess
                 x)))

; Funciona!
(cube (cube-root-iter 2 1 27))
(cube (cube-root-iter 2 1 64))