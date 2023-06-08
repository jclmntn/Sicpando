#lang sicp

; Quero entender um pouco o exercício proposto na pg 40, de contar de quantas ma-
; neiras se pode dar troco.

; Aqui define-se uma função que conta o troco considerando uma quantidade (amount)
; e 5 tipos de moeda (não é um argumento).
(define (count-change amount)
  (cc amount 5))

; Segunda parte do processo de se contar troco. A condição de parada é quando o
; amount é zero (remember The Little Schemer?), o que significa que não há mais
; dinheiro para gerar troco.

; Se o valor é negativo ou não existem tipos de moedas, não é possível dar troco.

; Por fim, a função se chama reduzindo o número de moedas disponíveis, além de
; de se chamar reduzindo o amount pela denominação das moedas. O segundo termo
; vai reduzindo amount e se chamando, até o ponto em que amount = 0 ou amount <0.
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

; Os tipos de moeda estão ordenados do maior para o menor, segundo esse procedimento
; ou função.
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1) ; Moeda de 1 centavo
        ((= kinds-of-coins 2) 5) ; Moeda de 5 centavos
        ((= kinds-of-coins 3) 10) ; Moeda de 10 centavos
        ((= kinds-of-coins 4) 25) ; Moeda de 25 centavos
        ((= kinds-of-coins 5) 50))) ; Moeda de 50 centavos

(cc 100 5)


; Exercício 1.11
; f como processo recursivo

;(define (f n)
;  (if (< n 3)
;      n
;      (+ (f (- n 1))
;         (* 2 (f (- n 2)))
;         (* 3 (f (- n 3))))))

; f como processo iterativo

(define (f n)
  (if (< n 3)
      n
      (f-iter 2 1 0 (- n 2)))) ; Esse condição de fronteira (f 3). 
(define (f-iter a b c count)
  (if (<= count 0)
      a
      (f-iter (+ a (* 2 b) (* 3 c)) a b (- count 1))))
; Nessa última parte, procure imaginar uma fila, o primeiro elemento é vai para
; o segundo elemento, o segundo vai para o terceiro e o terceiro é descartado.

; Exercício 1.12
; Esse é um bocado desafiador... Eu poderia usar car e cdr, mas acredito que estaria
; roubando já que o autor não ensinou a usar listas, nesse caso, preciso pensar
; num baseline...

; Uma coisa que é bastante óbvia é que o triângulo de pascal é basicamente composto
; por várias linhas. A primeira linha só tem um elemento, então ela é minha condição
; base e final do meu processo recursivo.

; Para cada linha do processo de pascal, eu terei um coluna adicional. Então na
; linha 4 eu terei 4 colunas. O valor da primeira coluna na quarta linha é 1 e o
; valor da quarta coluna quarta linha é 1; o valor da segunda coluna na quarta linha
; é o valor da primeira coluna na terceira linha somado ao valor da segunda coluna
; na terceira linha; o valor da primeira coluna na terceira linha é 1, enquanto o valor da segunda coluna
; na terceira linha é o valor da primeira coluna na segunda linha somada ao segundo valor da segunda linha.
; Ou seja...

(define (pascal row col)
  (cond
    ((= row 1) 1) ; Na linha um o valor é 1, caso base!
    ((or (= col 1) (= row col)) 1) ; Na primeira coluna o valor é 1 e na última coluna também, lembrando que o número de colunas depende do número de linhas!
    (else (+ (pascal (dec row) (dec col)) (pascal (dec row)  col))) 
    ))


; Agora, para fazer um triângulo de pascal, eu pensaria em como definir as linhas primeiro...
(define (build-row row counter)
  (if (= counter 0)
      '()
      (cons (pascal row counter) (build-row row (dec counter)))))
;
;(define (build-triangle n-rows)
;  (if (= n-rows 0)
;      '()
;      (cons (build-row n-rows n-rows) (build-triangle (dec n-rows)) )))

;(build-triangle 4) ; Estamos quase lá, só tem um problema: a ordem tá estranha!!


(define (build-triangle n-rows row)
  (if (= n-rows 0)
      '()
      (cons (build-row (inc row) (inc row)) (build-triangle (dec n-rows) (inc row)))))

(build-triangle 6 0) ; Agora sim! O código em si está um pouco feioso, mas está fazendo sentido.

