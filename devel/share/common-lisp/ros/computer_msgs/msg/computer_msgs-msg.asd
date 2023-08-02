
(cl:in-package :asdf)

(defsystem "computer_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "AiDetection" :depends-on ("_package_AiDetection"))
    (:file "_package_AiDetection" :depends-on ("_package"))
  ))