;;;; srfi-88.asd

(cl:in-package :asdf)


(defsystem :srfi-22
  :version "20200403"
  :description "SRFI 22 for CL: Running Scheme Scripts on Unix"
  :long-description "SRFI 22 for CL: Running Scheme Scripts on Unix
https://srfi.schemers.org/srfi-22"
  :author "CHIBA Masaomi"
  :maintainer "CHIBA Masaomi"
  :serial t
  :depends-on (:srfi-37)
  :components ((:file "srfi-22")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-22))))
  (let ((name "https://github.com/g000001/srfi-22")
        (nickname :srfi-22))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))

;;; *EOF*
