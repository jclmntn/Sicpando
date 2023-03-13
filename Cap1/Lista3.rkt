#lang sicp
; Exercício 1.9
; Seguindo na mesma linha do apresentado como exemplo para cálculo da sequência
; de fibonacci.
;(define (+ a b)
;  (if (= a 0)
;      b
;      (inc (+ (dec a) b))))

; Suponha a = 2 e b = 2, sabemos que seu resultado será 4. Pelo modelo de substi-
; tuição teremos...

(+ 2 2)
(inc (+ 1 2))
(inc (inc (+ 0 2)))
(inc (inc 2))
(inc 3)

; O que torna o processo claramente recursivo. As operações são armazenadas pelo
; interpretador.
           
;(define (+ a b)
;  (if (= a 0)
;      b
;      (+ (dec a) (inc b))))
;

; Nesse caso, começamos com o exemplo a = b = 2 também...

(+ 2 2)
(+ 1 3)
(+ 0 4)

; O processo é claramente iterativo, embora o procedimento seja recursivo (se chama)
; A razão por trás disso está no fato de que um dos argumentos da função captura
; o estado do processo. No exemplo anterior, cada passo do processo incluía uma chamada
; adicional de inc, nesse ambos argumentos são transformados.

; Exercício 1.10
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
(A 0 (A 0 (A 0 (A 1 7))))
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0(A 1 4)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0(A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
(A 0 (A 0 (A 0 (A 0 (A 0 32)))))
(A 0 (A 0 (A 0 (A 0 64))))
(A 0 (A 0 (A 0 128)))
(A 0 (A 0 256))
(A 0 512)
1024

; Desse resultado, fica claro que quando x = 1, teremos 2^n para todo n no
; conjunto dos números naturais (excluindo 0).
; (define (g n) (A 1 n))

(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 4)))
(A 1 16) ; A partir daqui já sabemos o que acontece... Teremos 2^16

; O resultado vem de uma função que pode ser generalizada por:
; (define (h n) (A 2 n)). Seu valor será definido por 2^(2^2^(...)), em que o
; número de 2 dentro no expoente dependerá de n, isso para todo n no conjunto dos
; números naturais (excluindo 0). Por exemplo:

;(h 1) ; 2
;(h 2) ; 2^2
;(h 3) ; 2^(2^2)
;(h 4) ; 2^(2^2^2)
;(h 5) ; 2^65536

;(A 3 3) ; Seguimos o mesmo processo do exercício anterior...
;(A 2 (A 3 2))
;(A 2 (A 2 (A 3 1)))
;(A 2 (A 2 2))
;(A 2 (A 1 (A 2 1)))
;(A 2 (A 1 2))
;(A 2 (A 0 (A 1 1)))
;(A 2 (A 0 2))
;(A 2 4) ; Que é igual ao exercício anterior!

; Ficou faltando f(n). Pela definição da função, f(n) nada mais é que:
; 2 * x para toto x pertencente aos números reais.
; (define (f n) (A 0 n))
