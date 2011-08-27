(defsystem qt-utils
  :serial t
  :depends-on ("ol-utils" "qt")
  :components ((:module "qt"
                        :serial t
                        :components ((:file "packages")
                                     (:file "camelcase")
                                     (:file "functions")
                                     (:file "classes")
                                     (:file "gui")))))