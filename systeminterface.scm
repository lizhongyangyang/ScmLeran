;检查文件
(file-exists? "/Users/admin/Documents/atomfiles/scm/hello.scm")


;删除文件
(delete-file "/Users/admin/Documents/atomfiles/scm/hello.scm")


;修改时间
(file-or-directory-modify-seconds "/Users/admin/Documents/atomfiles/scm/hello.scm")


;调用系统命令
(system "ls")

(define fname "spot")
(system (string-append "test -f" fname))
(system (string-append "rm -f" fname))


;环境变量
(getenv "HOME")
(getenv "SHELL")
