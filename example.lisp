#!/usr/local/bin/sbcl-srfi-22

(defun display-file (filename)
  (with-open-file (in filename)
    (loop :for line := (read-line in nil nil)
          :while line
          :do (write-line line))))

(defun main (arguments)
  (dolist (f (cdr arguments))
    (display-file f))
  0)
