#lang racket
(require racket/match)
(require "queue.rkt")

(provide (all-defined-out))

(define ITEMS 5)
(define DUMMY 9999)

(define-struct counter (index tt et queue is-open) #:transparent)
; Aveți libertatea să vă structurați programul cum doriți (dar cu restricțiile
; de mai jos), astfel încât funcția serve să funcționeze conform specificației.
; 
; Restricții (impuse de checker):
; - trebuie să existe în continuare funcția (empty-counter index)
; - cozile de la case trebuie implementate folosind noul TDA queue

(define (empty-counter index)
  (make-counter index 0 0 empty-queue 1))


;*********************************************************************************************************************


; Implementați funcția care simulează fluxul clienților pe la case.
; ATENȚIE: Față de etapa 3, apare un nou tip de cerere, așadar
; requests conține 5 tipuri de cereri (cele moștenite din etapa 3 plus una nouă):
;   - (<name> <n-items>) - persoana <name> trebuie așezată la coadă la o casă              (ca înainte)
;   - (delay <index> <minutes>) - casa <index> este întârziată cu <minutes> minute         (ca înainte)
;   - (ensure <average>) - cât timp tt-ul mediu al caselor este mai mare decât
;                          <average>, se adaugă case fără restricții (case slow)           (ca înainte)
;   - <x> - trec <x> minute de la ultima cerere, iar starea caselor se actualizează
;           corespunzător (cu efect asupra câmpurilor tt, et, queue)                       (ca înainte)
;   - (close <index>) - casa index este închisă                                            (   NOU!   )
; Sistemul trebuie să proceseze cele 5 tipuri de cereri în ordine, astfel:
; - persoanele vor fi distribuite la casele DESCHISE cu tt minim; nu se va întâmpla
;   niciodată ca o persoană să nu poată fi distribuită la nicio casă                       (mică modificare)
; - când o casă suferă o întârziere, tt-ul și et-ul ei cresc (chiar dacă nu are clienți);
;   nu aplicați vreun tratament special caselor închise                                    (ca înainte)
; - tt-ul mediu (ttmed) se calculează pentru toate casele DESCHISE, 
;   iar la nevoie veți adăuga case slow una câte una, până când ttmed <= <average>         (mică modificare)
; - când timpul prin sistem avansează cu <x> minute, tt-ul, et-ul și queue-ul tuturor 
;   caselor se actualizează pentru a reflecta trecerea timpului; dacă unul sau mai mulți 
;   clienți termină de stat la coadă, ieșirile lor sunt contorizate în ordine cronologică. (ca înainte)
; - când o casă se închide, ea nu mai primește clienți noi; clienții care erau deja acolo
;   avansează normal, până la ieșirea din supermarket                                    
; Rezultatul funcției serve va fi o pereche cu punct între:
; - lista sortată cronologic a clienților care au părăsit supermarketul:
;   - fiecare element din listă va avea forma (index_casă . nume)
;   - dacă mai mulți clienți ies simultan, sortați-i crescător după indexul casei
; - lista cozilor (de la case DESCHISE sau ÎNCHISE) care încă au clienți:
;   - fiecare element va avea forma (index_casă . coadă) (coada este de tip queue)
;   - lista este sortată după indexul casei


;; Functia update-counter cauta in lista de counters casa cu indexul cautat folosind recursivitate.
;; Dupa ce a fost gasita casa, se va aplica functia f asupra sa si apoi casa transformata va fi pusa
;; in lista finala counters, lista care va fi valoarea de retur a functiei.
(define (update-counter f old-counters counters index)
  (cond ((null? counters) old-counters)
        ((equal? index (counter-index (car counters))) (append old-counters (list (f (car counters))) (cdr counters)))
        (else
         (if (null? old-counters)
             (update-counter f (list (car counters)) (cdr counters) index)
             (update-counter f (append old-counters (list (car counters))) (cdr counters) index)))))


;; Functia update pregateste counters pentru functia update-counters
(define (update f counters index)
  (update-counter f '() counters index))


;**********************************************************************************************************************


;; Functia tt+ returneaza o precodura care la randul ei returneaza o copie a unei structuri care are
;; tt-ul adunat cu mins
(define (tt+ mins)
  (lambda(count) (struct-copy counter count [tt (+ (counter-tt count) mins)])))


;**********************************************************************************************************************


;; Functia et+ returneaza o precodura care la randul ei returneaza o copie a unei structuri care are
;; et-ul adunat cu mins
(define (et+ mins)
  (lambda(count) (struct-copy counter count [et (+ (counter-et count) mins)])))


;**********************************************************************************************************************


;; Functia add-to-empty-counter returneaza o copie a structurii C. Se adauga in coada numele si numarul
;; de produse ale noului client si se mareste tt si et cu n-items. Se trateaza cazul in care structura C are coada goala.
(define (add-to-empty-counter C client)
  ((tt+ (cdr client)) ((et+ (cdr client)) (struct-copy counter C [queue (enqueue client (counter-queue C))]))))


;; Functia add-to-empty-counter adauga clientul in structura care are o coada cu elemente.
;; Practic se va crea o copie a structurii vechi cu clientul adaugat in coada veche, iar tt va creste cu n-items.
(define (add-to-!empty-counter C client)
  ((tt+ (cdr client)) (struct-copy counter C [queue (enqueue client (counter-queue C))])))


;; Functia verifica si decide care din cele doua apeluri (add-to-empty-counter si add-to-!empty-counter)
;; trebuiesc apelate pentru client. Se returneaza o procedura.
(define (add-to-counter name items)
  (λ (C)
    (if (queue-empty? (counter-queue C)) (add-to-empty-counter C (cons name items))
        (add-to-!empty-counter C (cons name items)))))


;**********************************************************************************************************************


;; Functia min-tt-counter va trece prin fiecare casa si compara casele in functie de tt in felul urmator:
;; Daca lista caselor e goala se trimite lista cu id-ul si timpul de asteptare al casei "counter" care are cel mai mic timp.
;; Daca urmatoarea casa are timpul de asteptare mai mic se va retine in counter, iar in caz de egalitate counter va avea
;; referinta casei cu indicele mai mic.
(define (min-tt-counter counters counter)
  (cond ((null? counters) (cons (counter-index counter) (counter-tt counter)))   
        ((and (< (counter-tt (car counters)) (counter-tt counter)) (not (zero? (counter-is-open (car counters))))) (min-tt-counter (cdr counters) (car counters)))
        ((and (equal? (counter-tt (car counters)) (counter-tt counter)) (not (zero? (counter-is-open (car counters)))))
         (if (< (counter-index (car counters)) (counter-index counter))
             (min-tt-counter (cdr counters) (car counters))
             (min-tt-counter (cdr counters) counter)))
        (else (min-tt-counter (cdr counters) counter))))


;; Functia min-tt apeleaza min-tt-counter pentru a gasi casa cu tt minim folosind
;; recursivitate.
(define (min-tt counters)
  (min-tt-counter counters (struct-copy counter (empty-counter DUMMY) [tt DUMMY])))


;; Functia min-et-counter va trece prin fiecare casa si compara casele in functie de et in felul urmator:
;; Daca lista caselor e goala se trimite lista cu id-ul si timpul de asteptare al casei "counter" care are cel mai mic timp.
;; Daca urmatoarea casa nu are clienti atunci se va omite, iar daca are clienti atunci daca respectiva casa are timpul
;; de asteptare mai mic, aceasta va fi retinuta in counter, iar in caz de egalitate counter va avea referinta casei cu
;; index-ul mai mic.
(define (min-et-counter counters counter)
  (cond ((null? counters) (cons (counter-index counter) (counter-et counter)))
        ((queue-empty? (counter-queue (car counters))) (min-et-counter (cdr counters) counter))
        ((< (counter-et (car counters)) (counter-et counter)) (min-et-counter (cdr counters) (car counters)))
        ((equal? (counter-et (car counters)) (counter-et counter))
         (if (< (counter-index (car counters)) (counter-index counter))
             (min-et-counter (cdr counters) (car counters))
             (min-et-counter (cdr counters) counter)))
        (else (min-et-counter (cdr counters) counter)))); folosind funcția de mai sus


;; Functia min-et apeleaza min-tt-counter pentru a gasi casa cu tt minim folosind
;; recursivitate si o noua structura DUMMY.
(define (min-et counters)
  (min-et-counter counters ((et+ DUMMY) (empty-counter DUMMY))))


;; Functia min-times-counters apeleaza functiile min-tt si min-et si le scrie output-ul
;; intr-o lista pe care o va returna.
(define (min-times-counters counters)
  (list (min-tt counters) (min-et counters)))


;**********************************************************************************************************************


;; Functia remove-first-from-empty-counter elimina singurul client ramas din casa C
;; si modifica tt si et la 0.
(define (remove-first-from-empty-counter C)
  (struct-copy counter C [tt 0] [et 0] [queue (dequeue (counter-queue C))]))


;; Functia remove-first-from-!empty-counter elimina primul client din casa C, modifica et
;; cu numarul de produse al urmatorului client si se scade din tt et-ul pentru clientul eliminat.
(define (remove-first-from-!empty-counter C)
  (struct-copy counter C [tt (- (counter-tt C) (counter-et C))] [et (cdr (top (dequeue (counter-queue C))))] [queue (dequeue (counter-queue C))]))


;; Functia remove-first-from-counter apeleaza in functie de numarul clientilor din casa functia
;; potrivita pentru scoaterea clientului de la coada casei. 
(define (remove-first-from-counter C)   ; testată de checker
  (if (= 1 (+ (queue-size-l (counter-queue C)) (queue-size-r (counter-queue C)))) (remove-first-from-empty-counter C)
      (remove-first-from-!empty-counter C)))


;**********************************************************************************************************************


;; Functia set-fast-counters reface lista cu caselor rapide. Se foloseste in cazul in care
;; o casa a suferit modificari.
(define (set-fast-counters counter fast-counters old-fast-counters)
  (cond ((= (counter-index counter) (counter-index (car fast-counters))) (append (append old-fast-counters (list counter)) (cdr fast-counters)))
        ((null? old-fast-counters) (set-fast-counters counter (cdr fast-counters) (list (car fast-counters))))
        (else (set-fast-counters counter (cdr fast-counters) (append old-fast-counters (list (car fast-counters)))))))


;; Functia set-slow-counters reface lista caselor normale. Se foloseste in cazul in care
;; o casa a suferit modificari.
(define (set-slow-counters counter slow-counters old-slow-counters)
  (cond ((= (counter-index counter) (counter-index (car slow-counters))) (append (append old-slow-counters (list counter)) (cdr slow-counters)))
        ((null? old-slow-counters) (set-slow-counters counter (cdr slow-counters) (list (car slow-counters))))
        (else (set-slow-counters counter (cdr slow-counters) (append old-slow-counters (list (car slow-counters)))))))
              

;; Functia find-counter extrage structura casei cu indexul cautat alaturi de un numar care indica apartenenta
;; structurii la un tip de case.(1 - case rapide, 2 - case normale) 
(define (find-counter index fast-counters all-counters)
  (cond ((null? fast-counters)
         (if (= index (counter-index (car all-counters))) (list 2 (car all-counters))
             (find-counter index fast-counters (cdr all-counters))))
                 
        ((= index (counter-index (car fast-counters))) (list 1 (car fast-counters)))
        (else (find-counter index (cdr fast-counters) (cdr all-counters)))))


;*****************************************************************************************************************************************************


;; Functia delay-counter se foloseste de functia update care va folosi functiile tt+ si et+ pentu a creste tt si et
;; cu numarul de minute de la delay. La finalul modulului se va apela fuctia serve care va procesa urmatorul request.
(define (delay-counter index minutes fast-counters slow-counters requests people passed-minutes)
  (if (= (car (find-counter index fast-counters (append fast-counters slow-counters))) 1) (serve-helper requests (update (et+ minutes) (update (tt+ minutes) fast-counters index) index) slow-counters people passed-minutes)
      (serve-helper requests fast-counters (update (et+ minutes) (update (tt+ minutes) slow-counters index) index) people passed-minutes)))


;*****************************************************************************************************************************************************


;; Functia add-client adauga clientul in casele disponibile pentru el. Acum, inainte de a inchide programu :))) doar vazand liniile
;; din aceasta functie, am sa explic cum functioneaza acestea. Modul de actiune al functiilor de pe cele 3 cazuri este asemanator.
;; Daca luam din interior spre exterior avem prima oara functia min-times-counters care preia fie slow-counters fie toate casele si
;; returneaza o lista cu indexul casei cu tt min si tt-min + indexul casei cu et minim si et-min. Din aceasta lista se extrage folosind
;; apelul dublu al lui car indexul casei cu tt minim. Urmeaza gasirea structuri cu indexul gasit, de aceea se va apela find-counter.
;; Find-couter ne va da o lista cu un numar care defineste tipul casei (1 pentru fast, 2 pentru slow) si structura cautata. Se apeleaza
;; cadr ca sa se extraga structura si apoi se apeleaza (add-to-counter client). Apelul amintit mai devreme returneaza o procedura care mai
;; are nevoie de structura extrasa, deci am legat procedura de apelul lui fast-counter. Aceste 2 elemente vor returna o copie a structurii
;; cu tt minim, copie care are clientul adaugat in coada sa. Urmeaza apelul de set-slow-counters sau set-fast-counters care reface lista
;; de slow respectiv fast counter (in functie de tipul structurii). Ultimul lucru facut este apelul serve pentru procesarea urmatorului request.
;; Sper ca a fost clar :). In aceasta functie mai avem 2 if-uri care verifica prima oara cate produse are clientul respectiv pentru structura de
;; ce tip este.
(define (add-client name n-items fast-counters slow-counters requests people minutes)
  (if(> n-items ITEMS) (serve-helper requests fast-counters (set-slow-counters ((add-to-counter name n-items) (cadr (find-counter (car (car (min-times-counters slow-counters))) fast-counters (append fast-counters slow-counters)))) slow-counters '()) people minutes)
     (if (= (car (find-counter (car (car (min-times-counters (append fast-counters slow-counters)))) fast-counters (append fast-counters slow-counters))) 2)
         (serve-helper requests fast-counters (set-slow-counters ((add-to-counter name n-items) (cadr (find-counter (car (car (min-times-counters (append fast-counters slow-counters)))) fast-counters (append fast-counters slow-counters)))) slow-counters '()) people minutes)
         (serve-helper requests (set-fast-counters ((add-to-counter name n-items) (cadr (find-counter (car (car (min-times-counters (append fast-counters slow-counters)))) fast-counters (append fast-counters slow-counters)))) fast-counters '()) slow-counters people minutes)
         )))


;*****************************************************************************************************************************************************


;; Functia calculate-avg calculeaza timpul de asteptare mediu pentru toata lista de case, counters.
(define (calculate-avg counters sum num)
  (cond ((null? counters) (/ sum num))
        ((= 1 (counter-is-open (car counters))) (calculate-avg (cdr counters) (+ sum (counter-tt (car counters))) (add1 num)))
        (else (calculate-avg (cdr counters) sum num))))


;; Functia ensure-helper verifica daca este nevoie sa se adauge noi case prin compararea average-ului cu apelul functiei
;; calculate-avg. Daca media este mai mare decat average atunci se va mai adauga recursiv o noua casa pana cand media este
;; mai mica sau egala cu average. Altfel se trece la urmatorul request.
(define (ensure-helper average fast-counters slow-counters requests people minutes)
  (if (< average (calculate-avg (append fast-counters slow-counters) 0 0)) (ensure-helper average fast-counters (append slow-counters (list (empty-counter (add1 (counter-index (car (reverse slow-counters))))))) requests people minutes)
      (serve-helper requests fast-counters slow-counters people minutes)))


;*****************************************************************************************************************************************************


;; Functia show-counters preia lista de countere filtrate, filtrul fiind existenta
;; clientilor la coada casei, si le aranjeaza pe toate intr-o lista de perechi de
;; tip index . queue.
(define (show-counters counters Acc)
  (if (null? counters) Acc
      (show-counters (cdr counters) (append Acc (list (cons (counter-index (car counters)) (counter-queue (car counters))))))))


;; Functia show-people este folosita pentru afisarea persoanelor care au iesit
;; din case pe parcursul tuturor request-urilor.
(define (show-people people showed-people)
  (if (null? people) showed-people
      (show-people (cdr people) (append showed-people (list (cons (car (car people)) (cadr (car people))))))))


;*****************************************************************************************************************************************************


;; Functia min returneaza persoana care a iesit cel mai devreme din casa cu indicele
;; cel mai mic din lista people. Primul min person va fi un DUMMY care va avea valori foarte mari.
;; Se verifica daca lista de persoane este nula si apoi daca timpul persoanei din lista este mai
;; mic decat al persoanei retinute in min-person, daca da atunci persoana din lista va fi retinuta in
;; min-person, altfel se verifica aceleasi persoane la indici in cazul in care au timpul egal, altfel
;; se trece la urmatoarea persoana din lista.
(define (min people min-person)
  (cond ((null? people) min-person)
        ((< (caddr (car people)) (caddr min-person)) (min (cdr people) (car people)))
        ((= (caddr (car people)) (caddr min-person))
         (if (< (car (car people)) (car min-person))
         (min (cdr people) (car people))
         (min (cdr people) min-person)))
        (else min (cdr people) min-person)))


;; Functia sort are rol in sortarea corecta a listei de persoane in functie de timp si indexul casei.
;; Pentru sortare vor exista 3 liste: old pentru retinerea persoanelor peste care s-a trecut, people pentru
;; retinerea persoanelor peste care nu s-a trecut si sorted care este acumulatorul functiei si retine persoanele
;; deja sortate. Se itereaza prin people pana cand se gaseste persoana data de functia min si se trece in lista
;; sorted urmand sa se sorteze restul persoanelor pana cand listele old si people vor fi goale. Atunci se returneaza
;; lista sortata.
(define (sort old people sorted)
  (cond ((and (null? old) (null? people)) sorted)
        ((equal? (car people) (min people (list DUMMY DUMMY DUMMY))) (sort '() (append old (cdr people)) (append sorted (list (car people)))))
        (else (sort (append old (list (car people))) (cdr people) sorted))))


;; Functia sort-helper verifica o lista pentru cazurile de baza si daca nu se incadreaza,
;; se va apela functia sort.
(define (sort-helper people)
  (cond ((null?  people) '())
        ((= 1 (length people)) (list (car people)))
        (else (sort '() people '()))))


;*****************************************************************************************************************************************************


;; Functia serve-pass-time-through-counter este aproape la fel cu functia pass-time-through-counter cu diferenta
;; ca se retin intr-o lista persoanele care au iesit din case sub forma (indice casa - nume - timp).
(define (serve-pass-time-through-counter minutes passed-minutes people)
  (λ (C)
    (cond ((zero? minutes) (list C people))
          ((queue-empty? (counter-queue C))
           (if (> minutes (counter-tt C))
               (list (struct-copy counter C [tt 0] [et 0]) people)
               (list (struct-copy counter C [tt (- (counter-tt C) minutes)] [et (- (counter-et C) minutes)]) people)))
          (else
           (if (< minutes (counter-et C))
               (list (struct-copy counter C [tt (- (counter-tt C) minutes)] [et (- (counter-et C) minutes)]) people)
               ((serve-pass-time-through-counter (- minutes (counter-et C)) (+ passed-minutes (counter-et C)) (append people (list (list (counter-index C) (car (top (counter-queue C))) (+ passed-minutes (counter-et C)))))) (remove-first-from-counter C)))))))


;; Functia time-passing se asigura ca toate casele vor simti trecerea timpului :). Se va apela pentru fiecare casa functia
;; serve-pass-time-through-counter. Dupa iterarea tuturor caselor se trece la urmatorul request.
(define (time-passing minutes old-fast-counters fast-counters old-slow-counters slow-counters people passed-minutes requests)
  (cond ((null? slow-counters)
         (serve-helper requests old-fast-counters old-slow-counters (sort-helper people) (+ passed-minutes minutes)))
        ((null? fast-counters)
         (time-passing minutes old-fast-counters fast-counters (append old-slow-counters (list (car ((serve-pass-time-through-counter minutes passed-minutes '()) (car slow-counters))))) (cdr slow-counters) (append people (cadr ((serve-pass-time-through-counter minutes passed-minutes '()) (car slow-counters)))) passed-minutes requests))
        (else
         (time-passing minutes (append old-fast-counters (list (car ((serve-pass-time-through-counter minutes passed-minutes '()) (car fast-counters))))) (cdr fast-counters) old-slow-counters slow-counters (append people (cadr ((serve-pass-time-through-counter minutes passed-minutes '()) (car fast-counters)))) passed-minutes requests))))


;*****************************************************************************************************************************************************


; Functia close-counter cauta structura cu indexul dat ca parametru si o inlocuieste in
; categoria corespunzatoare de countere cu acelasi counter, doar ca este marcat ca inchis
; prin campul is-open = 0.
(define (close-counter idx fast-counters slow-counters people passed-minutes requests)
  (if (= (car (find-counter idx fast-counters (append fast-counters slow-counters))) 1) (serve-helper requests (set-fast-counters (struct-copy counter (cadr (find-counter idx fast-counters (append fast-counters slow-counters))) [is-open 0]) fast-counters '()) slow-counters people passed-minutes)
      (serve-helper requests fast-counters (set-slow-counters (struct-copy counter (cadr (find-counter idx fast-counters (append fast-counters slow-counters))) [is-open 0]) slow-counters '()) people passed-minutes)))


;*****************************************************************************************************************************************************


;; Functia serve-helper este centrul de comanda pentru toate request-urile caselor.
;; Este locul unde se verifica tipul de cerere si se apeleaza functia corespunzatoare.
;; De asemenea tot aici se vor retine toate persoanele care au trecut prin case sub forma
;; data la functia serve-pass-time-through-counter. Dupa executarea tuturor cererilor se
;; va returna folosind functia show-people lista persoanelor impreuna cu lista tuturor caselor.
(define (serve-helper requests fast-counters slow-counters people passed-minutes)
  (if (null? requests) (cons (show-people people '()) (show-counters (filter (lambda(C) (not (queue-empty? (counter-queue C)))) (append fast-counters slow-counters)) '()))
      (match (car requests)
        [(list 'delay index minutes)      (delay-counter index minutes fast-counters slow-counters (cdr requests) people passed-minutes)]
        [(list 'ensure average)           (ensure-helper average fast-counters slow-counters (cdr requests)  people passed-minutes)]
        [(list 'close idx)                (close-counter idx fast-counters slow-counters people passed-minutes (cdr requests))]
        [(list name n-items)              (add-client name n-items fast-counters slow-counters (cdr requests) people passed-minutes)]
        [x                                (time-passing x '() fast-counters '() slow-counters people passed-minutes (cdr requests))]
        )))


;; Functia serve preia parametrii dati si ii foloseste pentru apelarea
;; functiei serve-helper
(define (serve requests fast-counters slow-counters)
  (serve-helper requests fast-counters slow-counters '() 0))