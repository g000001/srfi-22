;;;; srfi-22.lisp

(defpackage :srfi-22
  (:use :cl :cl-user)
  (:export :main))

(cl:in-package :srfi-22)

#|(defun main (arguments)
  (declare (ignorable arguments))
  0)|#

#+sbcl
(progn
  ;;
  (sb-ext:save-lisp-and-die
   "sbcl-srfi-22"
   :purify T
   :executable T
   :toplevel (lambda ()
               (let ((script (and (second sb-ext:*posix-argv*)
                                  (probe-file (second sb-ext:*posix-argv*)) )))
                 (when script
                   ;; Handle shebang-line
                   (set-dispatch-macro-character #\# #\!
                                                 (lambda (stream char arg)
                                                   (declare (ignore char arg))
                                                   (read-line stream) ))
                   ;; Disable debugger
                   (setf sb-ext:*invoke-debugger-hook*
                         (lambda (condition hook)
                           (declare (ignore hook))
                           ;; Uncomment to get backtraces on errors
                           ;; (sb-debug:backtrace 20)
                           (format *error-output* "Error: ~A~%" condition)
                           (sb-ext:quit :unix-status 1) ))
                   (let ((*package* (find-package :srfi-22)))
                     (load script))
                   (sb-ext:quit :unix-status
                                (srfi-22:main (cdr sb-ext:*posix-argv*))) )))))
