(in-package :qt-utils)

(export '(q
          qconnect
          make-qinstance))

(defmacro q (function instance &rest args)
  "Aufrufen von Qt Funktionen, aber Notation der Funktionennamen im
lisp-style.  Sogar sind diese setf-able -- vorausgesetzt, die passende
Qt Funktion exisitiert."
  `(optimized-call t ,instance
                   ,(qfunname function)
                   ,@args))

(define-setf-expander q (property object &environment env)
  (with-gensyms!
    (multiple-value-bind (temps vals stores store-form access-form)
       (get-setf-expansion object env)
      (declare (ignorable stores store-form))
      (values (append1 temps g!object)
              (append1 vals access-form)
              (list g!store)
              `(progn
                 (q ,(symb 'set- property) ,g!object ,g!store)
                 ,g!store)
              `(q ,property ,g!object)))))

(defmacro qconnect (source signal sink slot)
  "Connect a signal to a slot"
  `(optimized-call T "QObject" "connect"
                   ,source (QSIGNAL ,(qsignature signal))
                   ,sink (QSLOT ,(qsignature slot))))

(defmacro! make-qinstance (class-name &rest parameters)
  "Benutze ähnlich wie make-instance.  Die ersten Parameter, die kein
keyword enthalten, werden direkt an den Konstruktor geschickt.  Die
anderen werden als Properties aufgefasst und mit setXxx eingestellt."
  (let* ((i (or (position-if #'keywordp parameters)
                (length parameters)))
         (standard-params (subseq parameters 0 i))
         (keyword-params  (group (subseq parameters i]) 2)))
    `(let ((,g!instance (optimized-new ,(qclassname class-name)
                                       ,@standard-params)))
       ,@(mapcar #`(setf (q ,(first a1) ,g!instance)
                         ,(second a1))
                 keyword-params)
       ,g!instance)))