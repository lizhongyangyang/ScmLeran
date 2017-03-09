;递归过程
(define factorial
    (lambda (n)
        (if (= n 0) 1
            (* n (factorial (- n 1))))))


;互递归过程
(define is-even?
    (lambda (n)
        (if (= n 0) #t
            (is-ood? (- n 1)))))

(define is-ood?
    (lambda (n)
        (if (= n 0) #f
            (is-even? (- n 1)))))

(is-even? 4)
(is-ood? 5)


;局部递归过程
(letrec ((local-even? (lambda (n)
                        (if (= n 0) #t
                            (local-ood? (- n 1)))))
         (local-ood? (lambda (n)
                        (if (= n 0) #f
                            (local-even? (- n 1))))))
    (list (local-even? 23) (local-ood? 23)))


;递归定义循环
(letrec ((countdown (lambda (i)
                        (if (= i 0) 'liftoff
                            (begin
                                (display i)
                                (newline)
                                (countdown (- i 1)))))))
    (countdown 10))

;命名let简写
(let countdown ((i 10))
    (if (= i 0) 'liftoff
        (begin
            (display i)
            (newline)
            (countdown (- i 1)))))

;尾递归调用
(define list-position
    (lambda (o l)
        (let loop ((i 0) (l l))
            (if (null? l) #f
                (if (eqv? (car l) o) i
                    (loop (+ i 1) (cdr l)))))))
(list-position 'c '(a b c d))

(define list-reverse!
    (lambda (s)
        (let loop ((s s) (r '()))
            (if (null? s) r
                (let ((d (cdr s)))
                    (set-cdr! s r)
                    (loop d s))))))
(define ls '(1 2 3 4))
(list-reverse! ls)


;特殊迭代
(define add2
    (lambda (x)
        (+ x 2)))
(map add2 '(1 2 3))
(map cons '(1 2 3) '(10 20 30))
(map + '(1 2 3) '(10 20 30))

;返回列表
(map display
    (list "one" "two" "buckle my shoe"))
;不返回任何值
(for-each display
    (list "one" "two" "buckle my shoe"))
