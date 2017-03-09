(if test-expression
    then-branch
    else-branch)


(define p 80)
(if (> p 70)
    'safe
    'unsafe)
(if (< p 90)
    'low-pressure)


(define a 10)
(define b 20)
(when (< a b)
    (display "a是")
    (display a)
    (display "b是")
    (display b)
    (display "a大于b"))

(define a 10)
(define b 20)
(if (< a b)
    (begin
        (display "a是")
        (display a)
        (display "b是")
        (display b)
        (display "a大于b")))

(define a 10)
(define b 20)
(unless (>= a b)
    (display "a是")
    (display a)
    (display "b是")
    (display b)
    (display "a大于b"))


(if (char<? c #\c) -1
    (if (char=? c #\c) 0
        1))

(cond ((char<? c #\c) -1)
      ((char=? c #\c) 0)
      (else 1))


(define c #\c)
(case c
    ((#\a) 1)
    ((#\b) 2)
    ((#\c) 3)
    (else 4))


(and 1 2)
(and #f 1)

(or 1 2)
(or #f 1)

;短路
(and 1 #f expression-guaranteed-to-cause-error)
(or 1 #f expression-guaranteed-to-cause-error)
