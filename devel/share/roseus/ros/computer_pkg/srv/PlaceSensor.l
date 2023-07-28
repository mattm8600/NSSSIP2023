;; Auto-generated. Do not edit!


(when (boundp 'computer_pkg::PlaceSensor)
  (if (not (find-package "COMPUTER_PKG"))
    (make-package "COMPUTER_PKG"))
  (shadow 'PlaceSensor (find-package "COMPUTER_PKG")))
(unless (find-package "COMPUTER_PKG::PLACESENSOR")
  (make-package "COMPUTER_PKG::PLACESENSOR"))
(unless (find-package "COMPUTER_PKG::PLACESENSORREQUEST")
  (make-package "COMPUTER_PKG::PLACESENSORREQUEST"))
(unless (find-package "COMPUTER_PKG::PLACESENSORRESPONSE")
  (make-package "COMPUTER_PKG::PLACESENSORRESPONSE"))

(in-package "ROS")





(defclass computer_pkg::PlaceSensorRequest
  :super ros::object
  :slots (_latitude _longitude _battery ))

(defmethod computer_pkg::PlaceSensorRequest
  (:init
   (&key
    ((:latitude __latitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:battery __battery) 0.0)
    )
   (send-super :init)
   (setq _latitude (float __latitude))
   (setq _longitude (float __longitude))
   (setq _battery (float __battery))
   self)
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:battery
   (&optional __battery)
   (if __battery (setq _battery __battery)) _battery)
  (:serialization-length
   ()
   (+
    ;; float64 _latitude
    8
    ;; float64 _longitude
    8
    ;; float32 _battery
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float32 _battery
       (sys::poke _battery (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _latitude
     (setq _latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _longitude
     (setq _longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float32 _battery
     (setq _battery (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass computer_pkg::PlaceSensorResponse
  :super ros::object
  :slots (_target_latitude _target_longitude ))

(defmethod computer_pkg::PlaceSensorResponse
  (:init
   (&key
    ((:target_latitude __target_latitude) 0.0)
    ((:target_longitude __target_longitude) 0.0)
    )
   (send-super :init)
   (setq _target_latitude (float __target_latitude))
   (setq _target_longitude (float __target_longitude))
   self)
  (:target_latitude
   (&optional __target_latitude)
   (if __target_latitude (setq _target_latitude __target_latitude)) _target_latitude)
  (:target_longitude
   (&optional __target_longitude)
   (if __target_longitude (setq _target_longitude __target_longitude)) _target_longitude)
  (:serialization-length
   ()
   (+
    ;; float64 _target_latitude
    8
    ;; float64 _target_longitude
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _target_latitude
       (sys::poke _target_latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_longitude
       (sys::poke _target_longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _target_latitude
     (setq _target_latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_longitude
     (setq _target_longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass computer_pkg::PlaceSensor
  :super ros::object
  :slots ())

(setf (get computer_pkg::PlaceSensor :md5sum-) "92d27cc93d35e7c5066371f928a11ffc")
(setf (get computer_pkg::PlaceSensor :datatype-) "computer_pkg/PlaceSensor")
(setf (get computer_pkg::PlaceSensor :request) computer_pkg::PlaceSensorRequest)
(setf (get computer_pkg::PlaceSensor :response) computer_pkg::PlaceSensorResponse)

(defmethod computer_pkg::PlaceSensorRequest
  (:response () (instance computer_pkg::PlaceSensorResponse :init)))

(setf (get computer_pkg::PlaceSensorRequest :md5sum-) "92d27cc93d35e7c5066371f928a11ffc")
(setf (get computer_pkg::PlaceSensorRequest :datatype-) "computer_pkg/PlaceSensorRequest")
(setf (get computer_pkg::PlaceSensorRequest :definition-)
      "float64 latitude
float64 longitude
float32 battery
---
float64 target_latitude
float64 target_longitude
")

(setf (get computer_pkg::PlaceSensorResponse :md5sum-) "92d27cc93d35e7c5066371f928a11ffc")
(setf (get computer_pkg::PlaceSensorResponse :datatype-) "computer_pkg/PlaceSensorResponse")
(setf (get computer_pkg::PlaceSensorResponse :definition-)
      "float64 latitude
float64 longitude
float32 battery
---
float64 target_latitude
float64 target_longitude
")



(provide :computer_pkg/PlaceSensor "92d27cc93d35e7c5066371f928a11ffc")


