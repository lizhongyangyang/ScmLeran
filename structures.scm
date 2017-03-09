;树结构定义
(defstruct tree height girth age leaf-shape leaf-color)
;自动生成make-tree构造过程
(define coconut
    (make-tree 'height 30
                'leaf-shape 'frond
                'age 5))
(tree.height coconut)
(tree.leaf-shape coconut)
(tree.girth coconut)

(set!tree.height coconut 40)
(set!tree.girth coconut 10)
(tree.height coconut)
(tree.girth coconut)


;默认初始化
(defstruct tree height girth age
    (leaf-shape 'frond)
    (leaf-color 'green))

(define palm
    (make-tree 'height 60))
(tree.height palm)

(define palntain
    (make-tree 'height 7
               'leaf-shape 'sheet))
(tree.height palntain)
(tree.leaf-shape palntain)
(tree.leaf-color palntain)


;宏结构定义
(define-macro defstruct
  (lambda (s . ff)
    (let ((s-s (symbol->string s)) (n (length ff)))
      (let* ((n+1 (+ n 1))
             (vv (make-vector n+1)))
        (let loop ((i 1) (ff ff))
          (if (<= i n)
            (let ((f (car ff)))
              (vector-set! vv i
                (if (pair? f) (cadr f) '(if #f #f)))
              (loop (+ i 1) (cdr ff)))))
        (let ((ff (map (lambda (f) (if (pair? f) (car f) f))
                       ff)))
          `(begin
             (define ,(string->symbol
                       (string-append "make-" s-s))
               (lambda fvfv
                 (let ((st (make-vector ,n+1)) (ff ',ff))
                   (vector-set! st 0 ',s)
                   ,@(let loop ((i 1) (r '()))
                       (if (>= i n+1) r
                           (loop (+ i 1)
                                 (cons `(vector-set! st ,i
                                          ,(vector-ref vv i))
                                       r))))
                   (let loop ((fvfv fvfv))
                     (if (not (null? fvfv))
                         (begin
                           (vector-set! st
                               (+ (list-position (car fvfv) ff)
                                  1)
                             (cadr fvfv))
                           (loop (cddr fvfv)))))
                   st)))
             ,@(let loop ((i 1) (procs '()))
                 (if (>= i n+1) procs
                     (loop (+ i 1)
                           (let ((f (symbol->string
                                     (list-ref ff (- i 1)))))
                             (cons
                              `(define ,(string->symbol
                                         (string-append
                                          s-s "." f))
                                 (lambda (x) (vector-ref x ,i)))
                              (cons
                               `(define ,(string->symbol
                                          (string-append
                                           "set!" s-s "." f))
                                  (lambda (x v)
                                    (vector-set! x ,i v)))
                               procs))))))
             (define ,(string->symbol (string-append s-s "?"))
               (lambda (x)
                 (and (vector? x)
                      (eqv? (vector-ref x 0) ',s))))))))))
