
(cl:in-package :asdf)

(defsystem "computer_pkg-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "PlaceSensor" :depends-on ("_package_PlaceSensor"))
    (:file "_package_PlaceSensor" :depends-on ("_package"))
  ))