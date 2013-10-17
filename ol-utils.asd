(defsystem ol-utils
  :serial t
  :depends-on (iterate)
  :components ((:file "packages")
               (:file "basics")
               (:file "reader")
               (:file "macrodef")
               (:file "conditionals")
               (:file "anaphoric")
               (:file "setf")
               (:file "sequences")
               (:file "functions")
               (:file "lists")
               (:file "trees")
               (:file "memoisation")
               (:file "lazy")
               (:file "arrays")
               (:file "lazy-array")
               (:file "nlazy-array")
               (:file "infinite-array")
               (:file "strings")
               (:file "arithmetic")
               (:file "tables")
               (:file "clos")
               (:file "applications")
               (:file "portability")))
