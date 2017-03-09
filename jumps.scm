;call-with-current-continuation
(+ 1 (call/cc
        ;续延过程参数
        (lambda (k)
            (+2 (k 3)))))
;(+ 1 []) --> (+ 1 3) --> 4


;保存续延k到变量r里
(define r #f)

(+ 1 (call/cc
        (lambda (k)
            (set! r k)
            (+ 2 (k 3)))))
(r 5)
;r会放弃自己的续延
(+ 3 (r 5))


;定义数字列表并把数乘起来
(define list-product
    (lambda (s)
        (let recur ((s s))
            (if (null? s) 1
                (* (car s) (recur (cdr s)))))))

;退出续延重写
(define list-product
    (lambda (s)
        (call/cc
            (lambda (exit)
                (let recur ((s s))
                    (if (null? s) 1
                        (if (= (car s) 0 (exit 0))
                            (* (car s) (recur (cdr s))))))))))


;树匹配
(define same-fringe?
    (lambda (treel tree2)
        (let loop ((ftree1 (flatten tree1))
                   (ftree2 (flatten tree2)))
            (cond ((and (null? ftree1) (null? ftree2)) #t)
                  ((or (null? ftree1) (null? ftree2)) #f)
                  ((eqv? (car ftree1) (car ftree2))
                   (loop (cdr ftree1) (cdr ftree2)))
                  (else #f)))))

(define flatten
    (lambda (tree)
        (cond ((null? tree) '())
              ((pair? (car tree))
               (append (flatten (car tree))
                       (flatten (cdr tree))))
              (else
                  (cons (car tree)
                        (flatten (cdr tree)))))))

;创建生成器重写
(define tree-generator
    (lambda (tree)
        (let ((caller '*))
            (letrec
                ((generate-leaves
                    (lambda ()
                        (let loop ((tree tree))
                            (cond ((null? tree) 'skip)
                                  ((pair? tree)
                                   (loop (car tree))
                                   (loop (cdr tree)))
                                  (else
                                   (call/cc
                                       (lambda (rest-of-tree)
                                            (set! generate-leaves
                                                (lambda ()
                                                    (rest-of-tree 'resume)))
                                            (caller tree))))))
                        (caller '()))))
                (lambda ()
                    (call/cc
                        (lambda (k)
                            (set! caller k)
                            (generate-leaves))))))))

(define same-fringe?
    (lambda (tree1 tree2)
        (let ((gen1 (tree-generator tree1))
              (gen2 (tree-generator tree2)))
          (let loop ()
            (let ((leaf1 (gen1))
                  (leaf2 (gne2)))
              (if (eqv? leaf1 leaf2)
                  (if (null? leaf1) #t (loop))
                  #f))))))
