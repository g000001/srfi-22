 #|
lispworks:
$ lispworks-7-1-0-amd64-darwin-gtk -build mkexe.lisp

sbcl:
$ sbcl --load mkexe.lisp

|#

#+lispworks
(load (sys:lispworks-file "config/siteinit.lisp"))


(asdf:load-system :srfi-22)


(in-package "https://github.com/g000001/srfi-22")


(save-exe)


;;; *EOF*
