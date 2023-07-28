;; Auto-generated. Do not edit!


(when (boundp 'drone_pkg::DroneOp)
  (if (not (find-package "DRONE_PKG"))
    (make-package "DRONE_PKG"))
  (shadow 'DroneOp (find-package "DRONE_PKG")))
(unless (find-package "DRONE_PKG::DRONEOP")
  (make-package "DRONE_PKG::DRONEOP"))
(unless (find-package "DRONE_PKG::DRONEOPREQUEST")
  (make-package "DRONE_PKG::DRONEOPREQUEST"))
(unless (find-package "DRONE_PKG::DRONEOPRESPONSE")
  (make-package "DRONE_PKG::DRONEOPRESPONSE"))

(in-package "ROS")





(defclass drone_pkg::DroneOpRequest
  :super ros::object
  :slots (_mode ))

(defmethod drone_pkg::DroneOpRequest
  (:init
   (&key
    ((:mode __mode) 0)
    )
   (send-super :init)
   (setq _mode (round __mode))
   self)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; int32 _mode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _mode
       (write-long _mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _mode
     (setq _mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass drone_pkg::DroneOpResponse
  :super ros::object
  :slots (_success ))

(defmethod drone_pkg::DroneOpResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass drone_pkg::DroneOp
  :super ros::object
  :slots ())

(setf (get drone_pkg::DroneOp :md5sum-) "46e3fbb42467cdb3ed60e9a1d6e7dbc3")
(setf (get drone_pkg::DroneOp :datatype-) "drone_pkg/DroneOp")
(setf (get drone_pkg::DroneOp :request) drone_pkg::DroneOpRequest)
(setf (get drone_pkg::DroneOp :response) drone_pkg::DroneOpResponse)

(defmethod drone_pkg::DroneOpRequest
  (:response () (instance drone_pkg::DroneOpResponse :init)))

(setf (get drone_pkg::DroneOpRequest :md5sum-) "46e3fbb42467cdb3ed60e9a1d6e7dbc3")
(setf (get drone_pkg::DroneOpRequest :datatype-) "drone_pkg/DroneOpRequest")
(setf (get drone_pkg::DroneOpRequest :definition-)
      "int32 mode
---
bool success
")

(setf (get drone_pkg::DroneOpResponse :md5sum-) "46e3fbb42467cdb3ed60e9a1d6e7dbc3")
(setf (get drone_pkg::DroneOpResponse :datatype-) "drone_pkg/DroneOpResponse")
(setf (get drone_pkg::DroneOpResponse :definition-)
      "int32 mode
---
bool success
")



(provide :drone_pkg/DroneOp "46e3fbb42467cdb3ed60e9a1d6e7dbc3")


