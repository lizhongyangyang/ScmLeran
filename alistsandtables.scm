;关联表
((a . 1) (b . 2) (c . 3))


;表格结构定义
(defstruct table (equ eqv?) (alist '()))


;得到给定键关联的值
(define table-get
    (lambda (tbl k . d)
        (let ((c (lassoc k (table.alist tbl) (table.equ tbl))))
            (cond (c (cdr c))
                ((pair? d) (car d))))))

;定义调用lassoc过程
(define lassoc
    (lambda (k al equ?)
        (let loop ((al al))
            (if (null? al) #f
                (let ((c (car al)))
                    (if (equ? (car c) k) c
                        (loop (cdr) al)))))))


;更新给定键关联的值
(define table-put!
    (lambda (tbl k v)
        (let ((al (table.alist tbl)))
            (let ((c (lassoc k al (table.equ tbl))))
                (if c (set-cdr! c v)
                    (set!table.alist tbl (cons (cons k v) al)))))))


;对表格的点对进行给定的操作
(define table-for-each
    (lambda (tbl p)
        (for-each
            (lambda (c)
                (p (car c) (cdr c)))
            (table.alist tbl))))
