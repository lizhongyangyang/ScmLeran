;类结构定义
(defstruct standard-class
    slots superclass method-names method-vector)

;创建新类
(define trivial-bike-class
    (make-standard-class
        'superclass #t
        'slots '(frame parts size)
        'method-names '()
        'method-vector #()))

;宏调用类
(define-macro create-class
    (lambda (superclass slots . methods)
        `(create-class-proc
            ,superclass
            (list ,@(map (lambda (slot) `',slot) slots))
            (list ,@(map (lambda (method) `',(car method)) methods))
            (vector ,@(map (lambda (method) `,(cadr method)) methods)))))

(define make-instance
    (lambda (class . slot-value-twosomes)
        (let* ((slotlist (standard-class.slots class))
               (n (length slotlist))
               (instance (make-vector (+ n 1))))
            (vector-set! instance 0 class)
            (let loop ((slot-value-twosomes slot-value-twosomes))
                (if (null? slot-value-twosomes) instance
                    (let ((k (list-position (car slot-value-twosomes) slotlist)))
                        (vector-set! instance (+ k 1)
                            (cadr slot-value-twosomes))
                        (loop (cddr slot-value-twosomes))))))))

;类实例化
(define my-bike
    (make-instance trivial-bike-class
                   'frame 'cromoly
                   'size '18.5
                   'parts 'alivio))
