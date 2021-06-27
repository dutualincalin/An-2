#lang racket
(require racket/match)

(provide (all-defined-out))

(define ITEMS 5)
(define DUMMY 9999)

;; Actualizăm structura counter cu informația et:
;; Exit time (et) al unei case reprezintă timpul până la ieșirea primului client de la casa respectivă,
;; adică numărul de produse de procesat pentru acest client + întârzierile suferite de casă (dacă există).
;; Ex:
;; la C3 s-au așezat întâi Ana cu 3 produse și apoi Geo cu 7 produse,
;; și C3 a fost întârziată cu 5 minute => et pentru C3 este 3 + 5 = 8 (timpul până când va ieși Ana).



; Redefinim structura counter.
(define-struct counter (index tt et queue) #:transparent)



; Actualizați implementarea empty-counter astfel încât să conțină și câmpul et.
(define (empty-counter index)
  (define C (make-counter index 0 0 '()))
C)



; Implementați o funcție care aplică o transformare casei cu un anumit index.
; f = funcție unară care se aplică pe un argument de tip casă, counters = listă de case,
; index = indexul casei din counters căreia îi veți aplica transformarea f
; Veți întoarce lista actualizată de case.
; Dacă nu există în counters o casă cu acest index, veți întoarce lista nemodificată.

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



; Memento: tt+ crește tt-ul unei case cu un număr dat de minute.
; Actualizați implementarea tt+ pentru:
; - a ține cont de noua reprezentare a unei case
; - a permite ca operații de tip tt+ să fie pasate ca argument funcției update în cel mai facil mod
; Obs: Pentru compatibilitatea cu primul argument al lui update, trebuie să obținem ușor din tt+ 
; o funcție unară care se aplică pe un argument de tip casă (v. funcții curry).
; Am eliminat parametrii lui tt+ din define-ul de mai jos astfel încât voi să determinați
; cum este cel mai bine ca tt+ să își primească parametrii.
; Din acest motiv checker-ul nu testează separat această funcție, dar asistentul va verifica
; faptul că ați implementat-o conform cerințelor.

;; Functia tt+ returneaza o precodura care la randul ei returneaza o copie a unei structuri care are
;; tt-ul adunat cu mins
(define (tt+ mins)
  (lambda(count) (struct-copy counter count [tt (+ (counter-tt count) mins)])))



; Implementați o funcție care crește et-ul unei case cu un număr dat de minute.
; Păstrați formatul folosit pentru tt+.
; Checker-ul nu testează separat această funcție.

;; Functia et+ returneaza o precodura care la randul ei returneaza o copie a unei structuri care are
;; et-ul adunat cu mins
(define (et+ mins)
  (lambda(count) (struct-copy counter count [et (+ (counter-et count) mins)])))



; Memento: add-to-counter adaugă o persoană (reprezentată prin nume și număr de produse) la o casă. 
; Actualizați implementarea add-to-counter pentru aceleași rațiuni pentru care am modificat tt+.
; Atenție la cum se modifică tt și et!
; Checker-ul nu testează separat această funcție.

;; Functia add-to-empty-counter returneaza o copie a structurii C. Se adauga in coada copiei numele
;; si numarul de produse ale noului client si se mareste tt si et cu n-items. Se trateaza cazul in
;; care structura C are coada goala.
(define (add-to-empty-counter C name n-items)
  (struct-copy counter C [tt (+ (counter-tt C) n-items)] [et (+ (counter-et C) n-items)] [queue (list(cons name n-items))]))


;; Functia add-to-empty-counter adauga clientul in structura care are o coada cu elemente.
;; Practic se va crea o copie a structurii vechi cu clientul adaugat in coada veche, iar tt va creste cu n-items.
(define (add-to-!empty-counter C name n-items)
  (struct-copy counter C [tt (+ (counter-tt C) n-items)] [queue (append (counter-queue C) (list(cons name n-items)))]))


;; Functia verifica si decide care din cele doua apeluri (add-to-empty-counter si add-to-!empty-counter)
;; trebuiesc apelate pentru client. Se returneaza o procedura.
(define (add-to-counter client)
  (lambda(count) (if (null? (counter-queue count))(add-to-empty-counter count (car client) (cadr client))
                     (add-to-!empty-counter count (car client) (cadr client)))))



; Întrucât vom folosi atât min-tt (implementat în etapa 1) cât și min-et (funcție nouă),
; definiți-vă o funcție mai abstractă din care să derive ușor atât min-tt cât și min-et.
; Prin analogie cu min-tt, definim min-et astfel:
; min-et = funcție care primește o listă de case și intoarce o pereche dintre:
; - indexul casei (din listă) care are cel mai mic et
; - et-ul acesteia
; (când mai multe case au același et, este preferată casa cu indexul cel mai mic)

;; Functia min-tt-counter va trece prin fiecare casa si compara casele in functie de tt in felul urmator:
;; Daca lista caselor e goala se trimite lista cu id-ul si timpul de asteptare al casei "counter" care are cel mai mic timp.
;; Daca urmatoarea casa are timpul de asteptare mai mic se va retine in counter, iar in caz de egalitate counter va avea
;; referinta casei cu indicele mai mic.
(define (min-tt-counter counters counter)
  (cond ((null? counters) (cons (counter-index counter) (counter-tt counter)))   
        ((< (counter-tt (car counters)) (counter-tt counter)) (min-tt-counter (cdr counters) (car counters)))
        ((equal? (counter-tt (car counters)) (counter-tt counter))
         (if (< (counter-index (car counters)) (counter-index counter))
             (min-tt-counter (cdr counters) (car counters))
             (min-tt-counter (cdr counters) counter)))
        (else (min-tt-counter (cdr counters) counter))))


;; Functia min-tt apeleaza min-tt-counter pentru a gasi casa cu tt minim folosind
;; recursivitate.
(define (min-tt counters)
  (min-tt-counter (cdr counters) (car counters)))


;; Functia min-et-counter va trece prin fiecare casa si compara casele in functie de et in felul urmator:
;; Daca lista caselor e goala se trimite lista cu id-ul si timpul de asteptare al casei "counter" care are cel mai mic timp.
;; Daca urmatoarea casa nu are clienti atunci se va omite, iar daca are clienti atunci daca respectiva casa are timpul
;; de asteptare mai mic, aceasta va fi retinuta in counter, iar in caz de egalitate counter va avea referinta casei cu
;; index-ul mai mic.
(define (min-et-counter counters counter)
  (cond ((null? counters) (cons (counter-index counter) (counter-et counter)))
        ((null? (counter-queue (car counters))) (min-et-counter (cdr counters) counter))
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



; Implementați o funcție care scoate prima persoană din coada unei case.
; Funcția presupune, fără să verifice, că există minim o persoană la coada casei C.
; Veți întoarce o nouă structură obținută prin modificarea cozii de așteptare.
; Atenție la cum se modifică tt și et!
; Dacă o casă tocmai a fost părăsită de cineva, înseamnă că ea nu mai are întârzieri.

;; Functia remove-first-from-empty-counter elimina singurul client ramas din casa C
;; si modifica tt si et la 0.
(define (remove-first-from-empty-counter C)
  (struct-copy counter C [tt 0] [et 0] [queue '()]))


;; Functia remove-first-from-!empty-counter elimina primul client din casa C, modifica et
;; cu numarul de produse al urmatorului client si se scade din tt et-ul pentru clientul eliminat.
(define (remove-first-from-!empty-counter C)
  (struct-copy counter C [tt (- (counter-tt C) (counter-et C))] [et (cdr (cadr (counter-queue C)))] [queue (cdr (counter-queue C))]))


;; Functia remove-first-from-counter apeleaza in functie de numarul clientilor din casa functia
;; potrivita pentru scoaterea clientului de la coada casei. 
(define (remove-first-from-counter C)
  (if (null? (cdr (counter-queue C))) (remove-first-from-empty-counter C)
      (remove-first-from-!empty-counter C)))
    


; Implementați funcția care simulează fluxul clienților pe la case.
; ATENȚIE: Față de etapa 1, funcția serve operează cu următoarele modificări:
; - nu mai avem doar 4 case, ci:
;   - fast-counters (o listă de case pentru maxim ITEMS produse)
;   - slow-counters (o listă de case fără restricții)
;   (Sugestie: folosiți funcția update pentru a obține comportamentul pe liste de case)
; - requests conține 4 tipuri de cereri (cele 2 din etapa anterioară plus 2 noi):
;   - (<name> <n-items>) - persoana <name> trebuie așezată la coadă la o casă
;   - (delay <index> <minutes>) - casa <index> este întârziată cu <minutes> minute
;   - (remove-first) - cea mai avansată persoană părăsește casa la care se află
;   - (ensure <average>) - cât timp tt-ul mediu al tuturor caselor este mai mare decât
;                          <average>, se adaugă case fără restricții (case slow)
; Sistemul trebuie să proceseze cele 4 tipuri de cereri în ordine, astfel:
; - persoanele vor fi distribuite la casele cu tt minim (dintre casele la care au voie)
;   (ca înainte, dar acum folosiți fast-counters și slow-counters)
; - când o casă suferă o întârziere, tt-ul și et-ul ei cresc (chiar dacă nu are clienți)
;   (puțin diferit față de etapa 1, și acum folosiți fast-counters și slow-counters)
; - persoana care părăsește supermarketul este persoana fruntașă la casa cu et-ul minim
;   (dintre casele care au clienți); dacă nicio casă nu are clienți, cererea e ignorată
; - tt-ul mediu (ttmed) se calculează pentru toate casele (și cele fast, și cele slow), 
;   iar la nevoie veți adăuga case slow una câte una, până când ttmed <= <average>
; Considerați că indecșii caselor încep de la 1 și sunt mereu în ordine.
; Ex:
; fast-counters conține casele 1-2, slow-counters conține casele 3-15
; => la nevoie veți adăuga întâi casa 16, apoi casa 17, etc.
; (puteți determina matematic de câte case noi este nevoie sau
;  puteți adăuga recursiv una câte una până când condiția este îndeplinită)

;; Nota: Am pus linii de stelute pentru a delimita modulele in functie de rolul lor in program.

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
(define (delay-counter index minutes fast-counters slow-counters requests)
  (if (= (car (find-counter index fast-counters (append fast-counters slow-counters))) 1) (serve requests (update (et+ minutes) (update (tt+ minutes) fast-counters index) index) slow-counters)
  (serve requests fast-counters (update (et+ minutes) (update (tt+ minutes) slow-counters index) index))))

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
(define (add-client client fast-counters slow-counters requests)
  (if(> (cadr client) ITEMS) (serve requests fast-counters (set-slow-counters ((add-to-counter client) (cadr (find-counter (car (car (min-times-counters slow-counters))) fast-counters (append fast-counters slow-counters)))) slow-counters '()))
     (if (= (car (find-counter (car (car (min-times-counters (append fast-counters slow-counters)))) fast-counters (append fast-counters slow-counters))) 2)
         (serve requests fast-counters (set-slow-counters ((add-to-counter client) (cadr (find-counter (car (car (min-times-counters (append fast-counters slow-counters)))) fast-counters (append fast-counters slow-counters)))) slow-counters '()))
         (serve requests (set-fast-counters ((add-to-counter client) (cadr (find-counter (car (car (min-times-counters (append fast-counters slow-counters)))) fast-counters (append fast-counters slow-counters)))) fast-counters '()) slow-counters)
         )))

;*****************************************************************************************************************************************************

;; Functia remove-first-update elimina primul client din casa ale carei date se gasesc in counter-list. Se apeleaza
;; functia remove-first-from-counter care elimina primul client din casa, urmata de refacerea listei de case din care
;; counter face parte. In final se apeleaza serve pentru urmatorul request.
(define (remove-first-update counter-list fast-counters slow-counters requests)
  (if (= (car counter-list) 1) (serve requests (set-fast-counters (remove-first-from-counter (cadr counter-list)) fast-counters '()) slow-counters)
      (serve requests fast-counters (set-slow-counters (remove-first-from-counter (cadr counter-list)) slow-counters '()))))


;; Functia remove-first-helper stabileste daca exista casa care sa aiba clienti folosind un Dummy. In cazul in care
;; exista apeleaza functia remove-first-update, iar in caz contrar se trece la urmatorul request.
(define (remove-first-helper fast-counters slow-counters requests)
  (if (= (car (cadr (min-times-counters (append fast-counters slow-counters)))) DUMMY) (serve requests fast-counters slow-counters)
       (remove-first-update (find-counter (car (cadr (min-times-counters (append fast-counters slow-counters)))) fast-counters (append fast-counters slow-counters)) fast-counters slow-counters requests)
   ))
  
;*****************************************************************************************************************************************************

;; Functia calculate-avg calculeaza timpul de asteptare mediu pentru toata lista de case, counters.
(define (calculate-avg counters sum num)
  (if (null? counters) (/ sum num)
        (calculate-avg (cdr counters) (+ sum (counter-tt (car counters))) (add1 num))))


;; Functia ensure-helper verifica daca este nevoie sa se adauge noi case prin compararea average-ului cu apelul functiei
;; calculate-avg. Daca media este mai mare decat average atunci se va mai adauga recursiv o noua casa pana cand media este
;; mai mica sau egala cu average. Altfel se trece la urmatorul request.
(define (ensure-helper average fast-counters slow-counters requests)
  (if (< average (calculate-avg (append fast-counters slow-counters) 0 0)) (ensure-helper average fast-counters (append slow-counters (list (empty-counter (add1 (counter-index (car (reverse slow-counters))))))) requests)
      (serve requests fast-counters slow-counters)))

;*****************************************************************************************************************************************************

;; Functia serve este centrul de comanda cu rol in prelucrarea cererilor de tip request. In functie de cerere functia apeleaza
;; functiile necesare executarii request-ului. In cazul in care toate cererile au fost executate, se returneaza toate casele.
(define (serve requests fast-counters slow-counters)
  (if (null? requests) (append fast-counters slow-counters)
      (match (car requests)
      [(list 'delay index minutes)              (delay-counter index minutes fast-counters slow-counters (cdr requests))]
      [(list remove-first)                      (remove-first-helper fast-counters slow-counters (cdr requests))]
      [(list 'ensure average)                   (ensure-helper average fast-counters slow-counters (cdr requests))]
      [(list name n-items)                      (add-client (list name n-items) fast-counters slow-counters (cdr requests))]
      
      )))

