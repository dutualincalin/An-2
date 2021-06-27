#lang racket
(require racket/match)

;; Dutu Alin Calin
;; 323 CD

(provide empty-queue)
(provide queue-empty?)
(provide enqueue)
(provide dequeue)
(provide top)

(provide (struct-out queue)) ; pentru testare

;; Lucrul cu o structură de date de tip coadă implică multe operații de tip:
;; - enqueue (adăugarea unui element la sfârșitul cozii)
;; - dequeue (scoaterea primului element din coadă)
;; Când reținem coada ca pe o listă, ca în etapele 1 și 2, complexitatea operațiilor este:
;; - O(n) pentru enqueue (din cauza complexității operației append)
;; - O(1) pentru dequeue (datorită complexității operației cdr)
;; Întrucât ambele operații sunt folosite intensiv, dorim cost amortizat constant (O(1))
;; atât pentru enqueue cât și pentru dequeue.
;;
;; Soluția: reprezentăm coada ca pe o colecție de 2 stive (liste):
;; - stiva left: din care vom scoate la dequeue (O(1) cât timp stiva are elemente)
;; - stiva right: în care vom adăuga la enqueue (O(1))
;; |     |    |     |
;; |     |    |__5__|
;; |__1__|    |__4__|
;; |__2__|    |__3__|
;;
;; Singurul caz în care o operație nu este O(1) este dequeue atunci când left este goală.
;; Pe exemplu: Presupunem că am scos deja 1 și 2 din coadă și facem un nou dequeue.
;; În acest caz, complexitatea este O(n):
;; - întâi mutăm toate elementele din right în left (în ordine, vor veni: 5, 4, 3)
;; |     |    |     |      |     |    |     |      |     |    |     |
;; |     |    |     |      |     |    |     |      |__3__|    |     |
;; |     |    |__4__|  ->  |__4__|    |     |  ->  |__4__|    |     |
;; |__5__|    |__3__|      |__5__|    |__3__|      |__5__|    |_____|
;; - apoi scoatem elementul din vârful stivei left, adică 3
;; Întrucât fiecare element din coadă va fi mutat maxim o dată din stiva right în
;; stiva left, costul amortizat pentru ambele operații este constant.


; Definim o structură care descrie o coadă prin:
; - left   (o stivă: a scoate un element din coadă = a face pop pe stiva left)
; - right  (o stivă: a adăuga un element în coadă = a face push în stiva right)
; - size-l (numărul de elemente din stiva left)
; - size-r (numărul de elemente din stiva right)
; Obs: Listele Racket se comportă ca niște stive (push = cons, pop = car)
(define-struct queue (left right size-l size-r) #:transparent) 



; Definiți valoarea care reprezintă o structură queue goală.
(define empty-queue
  (make-queue '() '() 0 0))


; Implementați o funcție care verifică dacă o coadă este goală.

;; Functia queue-empty? verifica daca cele doua stive din coada sunt goale.
(define (queue-empty? q)
  (and (null? (queue-left q)) (null? (queue-right q))))


; Implementați o funcție care adaugă un element la sfârșitul unei cozi.
; Veți întoarce coada actualizată.

;; Functia enqueue adauga elementul x in stiva dreapta a cozii. 
(define (enqueue x q)
  (struct-copy queue q [right (cons x (queue-right q))] [size-r (add1 (queue-size-r q))] ))


; Implementați o funcție care scoate primul element dintr-o coadă nevidă
; (nu verificați că e nevidă, pe coada vidă este firesc să dea eroare).
; Veți întoarce coada actualizată.

;; Functia movequeue muta toate elementele din stiva dreapta in stiva stanga.
(define (movequeue q)
  (if (null? (queue-right q)) q
      (movequeue (struct-copy queue q [left (cons (car (queue-right q)) (queue-left q))] [right (cdr (queue-right q))] [size-l (add1 (queue-size-l q))] [size-r (sub1 (queue-size-r q))] ))))

;; Functia deque elimina primul element al stivei stangi.
(define (dequeue q)
  (if (null? (queue-left q)) (struct-copy queue (movequeue q) [left (cdr (queue-left (movequeue q)))] [size-l (sub1 (queue-size-l (movequeue q)))] )
  (struct-copy queue q [left (cdr (queue-left q))] [size-l (sub1 (queue-size-l q))] )))


; Implementați o funcție care obține primul element dintr-o coadă nevidă
; (nu verificați că e nevidă, pe coada vidă este firesc să dea eroare).
; Veți întoarce elementul aflat la începutul cozii.
(define (top q)
  (if (null? (queue-left q)) (car (queue-left (movequeue q)))
      (car (queue-left q))))
