(in-package #:ol-utils)

(defun string-replace-all (pattern string replacement)
  "Replace all exact occurrences of pattern in string with
replacement."
  (let ((l (length pattern)))
    (with-output-to-string (str)
      (labels ((repl (pos)
                 (aif (search pattern string :start2 pos)
                      (progn
                        (princ (subseq string pos it) str)
                        (princ replacement str)
                        (repl (+ it l)))
                      (princ (subseq string pos) str))))
        (repl 0)))))

(defun string-join (sequence &optional (separator " ") start end)
  "Concatenate the string representation of the elements of
`sequence', with `separator' between consecutive elements. If `start'
or `end' is non-nil, put the separator also there."
  (with-output-to-string (stream)
    (le1 (first (not start))
      (map nil (lambda (x)
                 (if first (setf first nil) (princ separator stream))
                 (princ x stream))
           sequence))
    (when end (princ separator stream))))
