;;;; srfi-22.lisp
(defpackage "https://github.com/g000001/srfi-22"
  (:use :cl :srfi-37)
  (:export :main))


(cl:in-package "https://github.com/g000001/srfi-22")


(declaim (ftype (function (list) integer) main))


(defun srfi-22 ()
  #+lispworks
  (let ((script (and (second sys:*line-arguments-list*)
                     (probe-file (second sys:*line-arguments-list*)) )))
    (when script
      (let ((*package* (find-package "https://github.com/g000001/srfi-22"))
            (*load-verbose* nil))
        (load script))
      (lw:quit :status
               (main (cdr sys:*line-arguments-list*))) ))
  #+sbcl
  (let ((script (and (second sb-ext:*posix-argv*)
                     (probe-file (second sb-ext:*posix-argv*)) )))
    (when script
      ;; Handle shebang-line
      
      ;; Disable debugger
      (setf sb-ext:*invoke-debugger-hook*
            (lambda (condition hook)
              (declare (ignore hook))
              ;; Uncomment to get backtraces on errors
              ;; (sb-debug:backtrace 20)
              (format *error-output* "Error: ~A~%" condition)
              (sb-ext:quit :unix-status 1) ))
      (let ((*package* (find-package "https://github.com/g000001/srfi-22")))
        (load script))
      (sb-ext:quit :unix-status
                   (main (cdr sb-ext:*posix-argv*))) )))


(defun save-exe ()
  (set-dispatch-macro-character #\# #\!
                                (lambda (stream char arg)
                                  (declare (ignore char arg))
                                  (read-line stream) ))
  #+lispworks
  (lw:deliver 'srfi-22 "lw-srfi-22" 0)
  #+sbcl
  (sb-ext:save-lisp-and-die "sbcl-srfi-22"
                            :purify T
                            :executable T
                            :toplevel #'srfi-22))


;;; *EOF*
