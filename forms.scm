;Procedures过程
;创建自定义的过程
(lambda (x) (+ x 2))

(define add2
    (lambda (x) (+ x 2)))

(define (add2 x)
    (+ x 2))


;Apply应用
(define x '(1 2 3))

(apply + x)
;最后一个必须是列表
(apply + 1 2 3 x)


;Sequencing序列
(define dispaky3
    (lambda (arg1 arg2 arg3)
        ;lambda语句体是隐式begin代码结构此处可以不写
        (begin
            (display arg1)
            (display " ")
            (display arg2)
            (display " ")
            (display arg3)
            (newline))))
