#lang racket
(require racket/match)

(provide (all-defined-out))

(define ITEMS 5)

;; C1, C2, C3, C4 sunt case într-un supermarket.
;; C1 acceptă doar clienți care au cumparat maxim ITEMS produse (ITEMS este definit mai sus).
;; C2 - C4 nu au restricții.
;; Considerăm că procesarea fiecărui produs la casă durează un minut.
;; Casele pot suferi întarzieri (delay).
;; La un moment dat, la fiecare casă există 0 sau mai mulți clienți care stau la coadă.
;; Timpul total (tt) al unei case reprezintă timpul de procesare al celor aflați la coadă,
;; adică numărul de produse cumpărate de ei + întârzierile suferite de casa respectivă (dacă există).
;; Ex:
;; la C3 sunt Ana cu 3 produse și Geo cu 7 produse,
;; și C3 nu are întârzieri => tt pentru C3 este 10.


; Definim o structură care descrie o casă prin:
; - index (de la 1 la 4)
; - tt (timpul total descris mai sus)
; - queue (coada cu persoanele care așteaptă)
(define-struct counter (index tt queue) #:transparent)



; Ex.1 - Implementați o functie care intoarce o structură counter goală.
; tt este 0 si coada este vidă.
; Obs: la definirea structurii counter se creează automat o funcție make-counter pentru a construi date de acest tip


;; Functia empty-counter creeaza o noua structura cu tt 0 si queue gol
(define (empty-counter index)
  (define C (make-counter index 0 '()))
C)



; Ex.2 - Implementați o funcție care crește tt-ul unei case cu un număr dat de minute.


;; Functia tt+ face o copie a structurii cu tt-ul modificat
(define (tt+ C minutes)
  (define C2 (struct-copy counter C
              [tt (+ (match C[(counter index tt queue)tt]) minutes)]))
  C
  C2)


; Ex. 3 - Implementați o funcție care primește o listă de case și intoarce o pereche dintre:
; - indexul casei (din listă) care are cel mai mic tt
; - tt-ul acesteia
; Obs: când mai multe case au același tt, este preferată casa cu indexul cel mai mic


;; Functia min-counter va trece prin fiecare casa si compara casele in functie de tt in felul urmator:
;; Daca lista caselor e goala se trimite lista cu id-ul si timpul de asteptare al casei "counter" care are cel mai mic timp.
;; Daca urmatoarea casa are timpul de asteptare mai mic se va retine in counter, iar in caz de egalitate counter va avea
;; referinta casei cu indicele mai mic.
(define (min-counter counters counter)
  (cond ((null? counters) (cons (counter-index counter) (counter-tt counter)))   
        ((< (counter-tt (car counters)) (counter-tt counter)) (min-counter (cdr counters) (car counters)))
        ((equal? (counter-tt (car counters)) (counter-tt counter))
         (if (< (counter-index (car counters)) (counter-index counter))
             (min-counter (cdr counters) (car counters))
             (min-counter (cdr counters) counter)))
        (else (min-counter (cdr counters) counter))))


;; Functia min-tt are rolul de pregatire pentru intrarea in functia min-counter.
;; Verifica daca lista este nula si in caz afirmativ returneaza lista nula.
(define (min-tt counters)
  (if (null? counters)
      '()
      (min-counter (cdr counters) (car counters))))



; Ex. 4 - Implementați o funcție care adaugă o persoană la o casă.
; C = casa, name = numele persoanei, n-items = numărul de produse cumpărate
; Veți întoarce o nouă structură obținută prin așezarea perechii (name . n-items)
; la sfârșitul cozii de așteptare.


;; Functia add-to-empty-counter adauga clientul in structura care are coada nula.
;; Practic se va crea o copie a structurii vechi cu clientul adaugat, iar tt va creste cu n-items
(define (add-to-empty-counter C name n-items)
  (define C2 (struct-copy counter C [tt (+ (counter-tt C) n-items)] [queue (list(cons name n-items))]))C C2)


;; Functia add-to-empty-counter adauga clientul in structura care are o coada cu elemente.
;; Practic se va crea o copie a structurii vechi cu clientul adaugat in coada veche, iar tt va creste cu n-items.
(define (add-to-!empty-counter C name n-items)
  (define C2 (struct-copy counter C [tt (+ (counter-tt C) n-items)] [queue (append (counter-queue C) (list(cons name n-items)))]))C C2)


;; Functia add-to-counter verifica coada casei C si in functie de numarul de elemente
;; apeleaza una dintre cele 2 functii precedente acestei functii.
(define (add-to-counter C name n-items)
  (if (null? (counter-queue C))(add-to-empty-counter C name n-items)
  (add-to-!empty-counter C name n-items)))



; Ex. 5 - Implementați funcția care simulează fluxul clienților pe la case.
; requests = listă de cereri care pot fi de 2 tipuri:
; - (<name> <n-items>) - persoana <name> trebuie așezată la coadă la o casă
; - (delay <index> <minutes>) - casa <index> este întârziată cu <minutes> minute
; C1, C2, C3, C4 = structuri corespunzătoare celor 4 case
; Sistemul trebuie să proceseze aceste cereri în ordine, astfel:
; - persoanele vor fi distribuite la casele cu tt minim (dintre casele la care au voie)
; - când o casă suferă o întârziere, tt-ul ei crește


;; Functia delay creste timpul de asteptare al casei din request folosind functia tt+.
;; Acest apel va fi incadrat in urmatorul apel recursiv al functiei serve care va prelua
;; urmatorul request.
(define (delay requests counters)
  (cond ((equal? (cadr (car requests)) 1) (serve (cdr requests) (tt+ (car counters) (caddr (car requests))) (cadr counters) (caddr counters) (cadddr counters)))
        ((equal? (cadr (car requests)) 2) (serve (cdr requests) (car counters) (tt+ (cadr counters) (caddr (car requests))) (caddr counters) (cadddr counters)))
        ((equal? (cadr (car requests)) 3) (serve (cdr requests) (car counters) (cadr counters) (tt+ (caddr counters) (caddr (car requests))) (cadddr counters)))
        ((equal? (cadr (car requests)) 4) (serve (cdr requests) (car counters) (cadr counters) (caddr counters) (tt+ (cadddr counters) (caddr (car requests)))))))


;; Functia choose-best-counter va returna o lista cu structura si indicele casei cu
;; cel mai mic timp de asteptare folosind functia min-tt counters.
;; Se verifica mai intai numarul caselor, deoarece exista posibilitatea ca C1 sa nu fie
;; disponibila unor anumiti clienti, iar apoi in functie de output-ul lui min-tt se returneaza
;; casa cu cel mai min timp de asteptare impreuna cu index-ul ei.
(define (choose-best-counter counters)
  (if (equal? 4 (length counters))
      (cond ((equal? (car (min-tt counters)) 1) (list (car counters) 1))
            ((equal? (car (min-tt counters)) 2) (list (cadr counters) 2))
            ((equal? (car (min-tt counters)) 3) (list (caddr counters) 3))
            ((equal? (car (min-tt counters)) 4) (list (cadddr counters) 4)))
      
      (cond ((equal? (car (min-tt counters)) 2) (list (car counters) 2))
            ((equal? (car (min-tt counters)) 3) (list (cadr counters) 3))
            ((equal? (car (min-tt counters)) 4) (list (caddr counters) 4)))))


;; Functia add-client adauga noul client la casa cu cel mai mic timp de asteptare si care este disponibila clientului respectiv.
;; Se verifica daca actualul client e eligibil pentru prima casa si apoi se verifica cea mai buna casa pentru client.
;; In final se va apela recursiv functia serve care va primi lista cu uramtoarele request-uri urmate de casele de marcat, modificate
;; in functie de request-ul actual.
(define (add-client requests counters)
  (if (> (cadr (car requests)) ITEMS)
         (cond ((equal? (cadr (choose-best-counter (cdr counters))) 2)
                (serve (cdr requests) (car counters)
                       (add-to-counter (car (choose-best-counter (cdr counters))) (car (car requests)) (cadr (car requests))) (caddr counters) (cadddr counters)))
               
               ((equal? (cadr (choose-best-counter (cdr counters))) 3)
                (serve (cdr requests) (car counters) (cadr counters)
                      (add-to-counter (car (choose-best-counter (cdr counters))) (car (car requests)) (cadr (car requests))) (cadddr counters)))

               ((equal? (cadr (choose-best-counter (cdr counters))) 4)
                (serve (cdr requests) (car counters) (cadr counters) (caddr counters)
                                         (add-to-counter (car (choose-best-counter (cdr counters))) (car (car requests)) (cadr (car requests))))))
        
        (cond ((equal? (cadr (choose-best-counter counters)) 1)
                (serve (cdr requests) (add-to-counter  (car(choose-best-counter counters)) (car (car requests)) (cadr (car requests)))
                       (cadr counters) (caddr counters) (cadddr counters)))

               ((equal? (cadr (choose-best-counter counters)) 2)
                (serve (cdr requests) (car counters)
                       (add-to-counter (car (choose-best-counter counters))(car (car requests))(cadr (car requests))) (caddr counters) (cadddr counters)))
               
               ((equal? (cadr (choose-best-counter counters)) 3)
                (serve (cdr requests) (car counters) (cadr counters)
                      (add-to-counter (car (choose-best-counter counters)) (car (car requests)) (cadr (car requests))) (cadddr counters)))

               ((equal? (cadr (choose-best-counter counters)) 4)
                (serve (cdr requests) (car counters) (cadr counters) (caddr counters)
                                         (add-to-counter (car (choose-best-counter counters)) (car (car requests)) (cadr (car requests))))))))


;; Functia serve proceseaza toate reequest-urile pentru toate cele 4 case.
;; Prima oara se verifica daca exista request-uri si in caz afirmativ se
;; vor returna structurile celor 4 case. Altfel se verifica tipul request-ului
;; si se va apela functia corespunzatoare.
(define (serve requests C1 C2 C3 C4)

  ; puteți să vă definiți aici funcții ajutătoare (define în define)
  ; - avantaj: aveți acces la variabilele requests, C1, C2, C3, C4 fără a le retrimite ca parametri
  ; puteți de asemenea să vă definiți funcțiile ajutătoare în exteriorul lui "serve"
  ; - avantaj: puteți să vă testați fiecare funcție imediat ce ați implementat-o

  (if (null? requests)
      (list C1 C2 C3 C4)
      (match (car requests)
        [(list 'delay index minutes) (delay requests (list C1 C2 C3 C4))]
        [(list name n-items)         (add-client requests (list C1 C2 C3 C4))])))
