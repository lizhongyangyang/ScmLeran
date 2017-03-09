; 非确定运算符
(amb 1 2)
(amb #f #t)
(if (amb #f #t)
    1
    (amb))


;用scheme实现amb
;定义处理基本错误续延的机制
(define amb-fail '*)

(define initialize-amb-fail
    (lambda ()
        (set! amb-fail
            (lambda ()
                (error "amb tree exhausted")))))
(initialize-amb-fail)

;定义amb宏
(define-macro amb
    (lambda alts...
        `(let ((+prev-amb-fail amb-fail))
            (call/cc
                (lambda (+sk)
                    ,@(map (lambda (alt)
                            `(call/cc
                                (lambda (+fk)
                                    (set! amb-fail
                                        (lambda ()
                                            (set! amb-fail +prev-amb-fail)
                                            (+fk 'fail)))
                                    (+sk ,alt)))
                            alts...))
                    (+prev-amb-fail))))))

;在scheme中使用amb
(amb 1 2 3 4 5 6 7 8 9 10)

(define number-between
    (lambda (lo hi)
        (let loop ((i lo))
            (if (> i hi) (amb)
                (amb i (loop (+ i 1)))))))
(number-between 1 6)


(define assert
    (lambda (pred)
        (if (not pred) (amb))))

(define gen-prime
    (lambda (hi)
        (let ((i (number-between 2 hi)))
            (assert (prime? i))
            i)))

(amb)
(amb)

(bag-of
    (gen-prime 20))

(define-macro bag-of
    (lambda (e)
        `(let ((+prev-amb-fail amb-fail)
               (+results '()))
            (if (call/cc)
                (lambda (+k)
                    (set! amb-fail (lambda () (+k #f)))
                    (let ((+v ,e))
                        (set! +results (cons +v +results))
                        (+k #t)))
                (amb-fail))
            (set! amb-fail +prev-amb-fail)
            (reverse! +results))))


;Kalotan谜题
(define solve-kalotan-puzzle
    (lambda ()
        (let ((parent1 (amb 'm 'f))
              (parent2 (amb 'm 'f))
              (kibi (amb 'm 'f))
              (kibi-self-desc (amb 'm 'f))
              (kibi-lied? (amb #t #f)))
          (assert
            (distinct? (list parent1 parent2)))
          (assert
            (if (eqv? kibi 'm)
                (not kibi-lied?)))
          (assert
            (if kibi-lied?
                (xor
                    (and (eqv? kibi-self-desc 'm)
                         (eqv? kibi 'f))
                    (and (eqv? kibi-self-desc 'f)
                         (eqv? kibi 'm)))))
          (asset
            (if (eqv? parent1 'm)
                (and
                    (eqv? kibi-self-desc 'm)
                    (xor
                        (and (eqv? kibi 'f)
                             (eqv? kibi-lied? #f))
                        (and (eqv? kibi 'm)
                             (eqv? kibi-lied #t))))))
          (assert
            (if (eqv? parent1 'f)
                (and
                    (eqv? kibi 'f)
                    (eqv? kibi-lied #t))))
          (list parent1 parent2 kibi))))
(solve-kalotan-puzzle)
