;宏定义when
(define-macro when
    (lambda (test . branch)
        (list 'if test
            (cons 'begin branch))))

(when (< (pressure tube) 60)
    (open-valve tube)
    (attach floor-pump tube)
    (depress floor-pump 5)
    (detach floor-pump tibe)
    (close-valve tube))

(apply
    (lambda (test . branch)
        (list 'if test
            (cons 'begin branch)))
    '((< (pressure tube) 60
            (open-valve tube)
            (attach floor-pump tube)
            (depress floor-pump 5)
            (detach floor-pump)
            (close-valve tube))))

(if (< (pressure tube) 60)
    (begin
        (open-valve tube)
        (attach floor-pump tube)
        (depress floor-pump 5)
        (detach floor-pump tube)
        (close-valve tube)))


(define-macro unless
    (lambda (test . branch)
        (list 'if
            (list 'not test)
            (cons 'begin branch))))

(define-macro unless
    (lambda (test . branch)
        (cons 'when
            (cons (list 'not test) branch))))


;指定一个扩展为模版
(list 'IF test
    (cons 'BEGIN branch))

`(IF ,test
    (BEGIN ,@branch))

(define-macro when
    (lambda (test . branch)
        `(IF ,test
            (BEGIN ,@branch))))

(IF (< (pressure tube) 60)
    (BEGIN
        (open-valve tube)
        (attach floor-pump tube)
        (depress floor-pump 5)
        (detach floor-pump tube)
        (close-valve tube)))


;避免在宏内部产生变量捕获
(define-macro my-or
    (lambda (x y)
        `(if ,x ,x ,y)))
;返回第一个为真的值
(my-or 1 2)
(my-or #f 2)

(my-or
    (begin
        (display "doing first argument")
        (newline)
        #t)
    2)

(define-macro my-or
    (lambda (x y)
        `let ((temp ,x))
            (if temp temp ,y)))
(define temp 3)
(my-or #f temp)

(define-macro my-or
    (lambda (x y)
        `let ((+temp ,x))
            (if +temp +temp ,y)))

(define-macro my-or
    (lambda (x y)
        (let ((temp (gensym)))
            `(let ((,temp ,x))
                (if ,temp ,temp ,y)))))


;更复杂宏
(fluid-let ((x 9) (y (+ y 1)))
    (+ x y))

(let ((OLD-X x) (OLD-Y y))
    (set! x 9)
    (set! y (+ y 1))
    (let ((RESULT (begin (+ x y))))
        (set! x OLD-X)
        (set! y OLD-Y)
        RESULT)

(define-macro fluid-let
    (lambda (xexe . body)
        (let ((xx (map car xexe)))
            (ee (map cadr xexe))
            (old-xx (map (lambda (ig) (gensym)) xexe))
            (result (gensym))
            `(let ,(map (lambda (old-x x) `(,old-x ,x))
                    old-xx xx
                    ,@(map (lambda (x e)))
                    `(set! ,x ,e
                        xx ee
                        (let ((,result (begin ,@body))))
                        ,@(map (lambda (x old-x)))
                        `(set! ,x ,old-x
                            xx old-xx
                            ,result))))))

(let ((GEN-63 x) (GEN-64 y))
    (set! x 9)
    (set! y (+ y 1))
    (let ((GEN-65 (begin (+ x y))))
        (set! x GEN-63)
        (set! y GEN-64)
        GEN-65))
