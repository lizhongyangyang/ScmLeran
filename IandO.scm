;read过程读取指定端口的下一个字符表达式
;read-char过程读取指定端口下一个字符
;read-line过程读取指定端口的下一行并返回一个字符串
;write过程把一个字符表达式以一种machine-readline的形式写入指定端口
;write-char过程把一个字符<不带#\>写入指定端口
;display过程把一个字符表达式以一种human-readline的形式写入指定端口

;文件端口
(display 9)
(display 9 (current-output-port))

(define i (open-input-file "hello.txt"))
(read-char i)

(define j (read i))
j

(define o (open-output-file "greeting.txt"))
(display "hello" o)
(write-char #\space o)
(display 'world o)
(newline o)
(close-output-port o)


;端口自动打开和关闭
(call-with-input-file "hello.txt"
    (lambda (i)
        (let* ((a (read-line i))
               (b (read-line i))
               (c (read-line i)))
            (list a b c))))


;字符串端口
(define i (open-input-string "hello world"))
(read-char i)
(read i)
(read i)

(define o (open-putput-string))
(write 'hello o)
(write-char #\, o)
(display " " o)
(display "world" o)

(get-output-string o)


;加载文件
(load /Users/admin/Documents/atomfiles/scm/hello.scm)
