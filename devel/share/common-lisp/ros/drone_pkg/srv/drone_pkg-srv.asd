
(cl:in-package :asdf)

(defsystem "drone_pkg-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "DroneOp" :depends-on ("_package_DroneOp"))
    (:file "_package_DroneOp" :depends-on ("_package"))
    (:file "PlaceSensor" :depends-on ("_package_PlaceSensor"))
    (:file "_package_PlaceSensor" :depends-on ("_package"))
  ))