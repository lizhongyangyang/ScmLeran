;引擎表示服从时间抢占的运算过程
(define printn-engine
    (make-engine
        (lambda ()
            (let loop ((i 0))
                (display i)
                (display " ")
                (loop (+ i 1))))))

(define *more* #f)
(printn-engine 50 list
    (lambda (ne)
        (set! *more* ne)))
(*more* 50 list
    (lambda (ne)
        (set! *more* ne)))


;时钟
;设置中断处理器
(clock 'set-handler
    (lambda ()
        (error "Say goodnight, cat!")))
;把时钟的剩余时间片重置
(clock 'set 9)


;flat引擎
(define *engine-escape* #f)
(define *engine-entrance* #f)

(clock 'set-handler
    (lambda ()
        (call/cc *engine-escape*)))

(define make-engine
    (lambda (th)
        (lambda ticks success failure
            (let* ((ticks-left 0)
                   (engine-succeeded? #f)
                   (result
                       (call/cc
                           (lambda (k)
                                (set! *engine-escape* k)
                                (let ((result
                                        (call/cc
                                            (lambda (k)
                                                (set! *engine-entrance* k)
                                                (clock 'set ticks)
                                                (let ((v (th)))
                                                    (*engine-entrance* v))))))
                                  (set! ticks-left (clock 'set *infinity*))
                                  (set！ engine-succeeded? #t)
                                  result)))))
                (if engine-succeeded?
                    (success result ticks-left)
                    (failure
                        (make-engine
                            (lambda ()
                                (result 'resume)))))))))


;nestable引擎
(define make-engine
    (lambda (th)
        (lambda (ticks s f)
            (let* ((parent-ticks
                    (clock 'set *infinity*)
                    (child-available-ticks
                        (clock-min parent-ticks ticks))
                    (parent-ticks-left
                        (clock-minus parent-ticks child-available-ticks))
                    (child-available-ticks
                        (clock-minus ticks child-available-ticks))
                    (ticks-left 0)
                    (engine-succeeded? #f)
                    (result
                        (fluid-let ((*engine-escape* #f)
                                    (*engine-entrance* #f))
                            (call/cc
                                (lambda (k)
                                    (set! *engine-escape* k)
                                    (let ((result
                                            (call/cc
                                                (lambda (k)
                                                    (set! *engine-entrance* k)
                                                    (clock 'set child-available-ticks)
                                                    (let ((v (th)))
                                                        (*engine-entrance* v))))))
                                        (set! ticks-left
                                            (let ((n (clock 'set *infinity*)))
                                                (if (eqv? n *infinity*) 0 n)))
                                        (set! engine-succeeded? #t)
                                        result)))))))))
        (set! parent-ticks-left
            (clock-plus parent-ticks-left ticks-left))
        (set! ticks-left
            (clock-plus child-ticks-left ticks-left))
        (clock 'set parent-ticks-left)
        (cond
            (engine-succeeded? (s result ticks-left))
            ((= ticks-left 0)
             (f (make-engine (lamdba () (result 'resume)))))
            (else
             ((make-engine (lamdba () (result 'resume)))
              ticks-left s f)))))
