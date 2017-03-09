;S表达式

;布尔类型
;#t表示true
(boolean? #t)
;#f表示false
(boolean? #f)
;检测参数是否为boolean类型
(boolean? "Hello World")
;取反操作
(not #f)
(not #t)
(not "Hello World")


;数字类型
;数字类型判断
(number? 42)
(number? #t)
(complex? 2+3i)
(real? 2+3i)
(real? 3.1416)
(real? 22/7)
(real? 42)
(rational? 2+3i)
(rational? 3.1416)
(rational? 22/7)
(integer? 22/7)
(integer? 42)
;通用相等判断
(eqv? 42 42)
(eqv? 42 #f)
(eqv? 42 42.0)
;已知类型判断
(= 42 42)
(= 42 #f)
(= 42 42.0)
;其他数字比较
(< 3 2)
(>= 4.4 3)
;数字运算过程
(+ 1 2 3)
(- 5.3 2)
(* 1 2 3)
(/ 6 3)
(/ 22 7)
(expt 2 3)
(expt 4 1/2)
;取最
(max 1 3 4 2 3)
(min 1 3 4 2 3)
;取绝对值
(abs 3)
(abs -4)


;字符类型
;字符类型判断
(char? #c)
(char? 1)
(char? #\;)
;字符类型比较
(char=? #\a #\a)
(char<? #\a #\b)
(char>=? #\a #\b)
;忽略大小写比较
(char-ci=? #\a #\A)
(char-ci<? #\a #\B)
;大小写类型转换
(char-upcase #\a)
(char-downcase #\A)


;标识符类型
;创建单纯标识
(quote xyz)
'xyz
;标识符类型判断
(symbol? 'xyz)
(symbol? 42)
;标识符类型通常不区分大小写
(eqv? 'Calorie 'calorie)
;创建全局变量
(define xyz 9)
;改变变量的值
(set! xyz #\c)


;复合数据类型
;字符串类型
"Hello World"
(string #\h #\e #\l #\l #\o)
(define greeting "Hello World")
;索引指定
(string-ref greeting 0)
;生成新字符串
(string-append "E" "Pluribus" "Unum")
;指定字符串长度
(define a-3-char-long-string (make-string 3))
;字符串类型判断
(string? 123)
(string? "Hello Woald")
;替换索引位置字符
(string-set! hello 1 #\a)


;向量类型
(vector 0 1 2 3 4)
(define v (make-vactor 5))


;点对类型
(cons 1 #t)
'(1 . #t)
(define x (cons 1 #t))
(car x)
(cdr x)


;列表类型
(list 1 2 3 4)
'(1 2 3 4)
(define y (list 1 2 3 4))
(list-ref y 0)
(list-tail y 1)


;数据类型转换
(char->integer #\d)
(integer->char 50)
(string->list "hello")
(string->number "16")
(string->symbol "string")
