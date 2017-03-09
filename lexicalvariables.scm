(define x 9)

(define add2
    (lambda (x)
        (+ x 2)))
x
(add2 3)
(add2 x)
x


(set! x 20)

(define add2
    (lambda (x)
        (set! x (+ x 2))
        x))
(add2 x)
x


(define counter 0)

;thunk无参数过程
(define bump-counter
    (lambda ()
        (set! counter (+ counter 1))
        counter))
;每次调用修改全局变量并返回当前的值
(bump-counter)
(bump-counter)
(bump-counter)


;创建局部变量
(let ((x 1)
      (y 2)
      (z 3))
    (list x y z))


;初始化引用x指向全局变量
(let ((x 1)
      (y x))
    (+ x y))


;初始化引用先创建的变量为后创建的变量赋值
(let* ((x 1)
       (y x))
    (+ x y))

(let ((x 1))
    (let ((y x))
        (+ x y)))


(let ((cons (lambda (x y) (+ x y))))
    (cons 1 2))


;设置临时全局变量
(fluid-set ((counter 99))
    (display (bump-counter)) (newline)
    (display (bump-counter)) (newline)
    (display (bump-counter)) (newline))
counter
