;; Auto-generated. Do not edit!


(when (boundp 'computer_msgs::AiDetection)
  (if (not (find-package "COMPUTER_MSGS"))
    (make-package "COMPUTER_MSGS"))
  (shadow 'AiDetection (find-package "COMPUTER_MSGS")))
(unless (find-package "COMPUTER_MSGS::AIDETECTION")
  (make-package "COMPUTER_MSGS::AIDETECTION"))

(in-package "ROS")
;;//! \htmlinclude AiDetection.msg.html


(defclass computer_msgs::AiDetection
  :super ros::object
  :slots (_timestamp_ns _class_id _frame_id _class_name _cam _class_confidence _detection_confidence _x_min _y_min _x_max _y_max ))

(defmethod computer_msgs::AiDetection
  (:init
   (&key
    ((:timestamp_ns __timestamp_ns) 0)
    ((:class_id __class_id) 0)
    ((:frame_id __frame_id) 0)
    ((:class_name __class_name) "")
    ((:cam __cam) "")
    ((:class_confidence __class_confidence) 0.0)
    ((:detection_confidence __detection_confidence) 0.0)
    ((:x_min __x_min) 0.0)
    ((:y_min __y_min) 0.0)
    ((:x_max __x_max) 0.0)
    ((:y_max __y_max) 0.0)
    )
   (send-super :init)
   (setq _timestamp_ns (round __timestamp_ns))
   (setq _class_id (round __class_id))
   (setq _frame_id (round __frame_id))
   (setq _class_name (string __class_name))
   (setq _cam (string __cam))
   (setq _class_confidence (float __class_confidence))
   (setq _detection_confidence (float __detection_confidence))
   (setq _x_min (float __x_min))
   (setq _y_min (float __y_min))
   (setq _x_max (float __x_max))
   (setq _y_max (float __y_max))
   self)
  (:timestamp_ns
   (&optional __timestamp_ns)
   (if __timestamp_ns (setq _timestamp_ns __timestamp_ns)) _timestamp_ns)
  (:class_id
   (&optional __class_id)
   (if __class_id (setq _class_id __class_id)) _class_id)
  (:frame_id
   (&optional __frame_id)
   (if __frame_id (setq _frame_id __frame_id)) _frame_id)
  (:class_name
   (&optional __class_name)
   (if __class_name (setq _class_name __class_name)) _class_name)
  (:cam
   (&optional __cam)
   (if __cam (setq _cam __cam)) _cam)
  (:class_confidence
   (&optional __class_confidence)
   (if __class_confidence (setq _class_confidence __class_confidence)) _class_confidence)
  (:detection_confidence
   (&optional __detection_confidence)
   (if __detection_confidence (setq _detection_confidence __detection_confidence)) _detection_confidence)
  (:x_min
   (&optional __x_min)
   (if __x_min (setq _x_min __x_min)) _x_min)
  (:y_min
   (&optional __y_min)
   (if __y_min (setq _y_min __y_min)) _y_min)
  (:x_max
   (&optional __x_max)
   (if __x_max (setq _x_max __x_max)) _x_max)
  (:y_max
   (&optional __y_max)
   (if __y_max (setq _y_max __y_max)) _y_max)
  (:serialization-length
   ()
   (+
    ;; int64 _timestamp_ns
    8
    ;; uint32 _class_id
    4
    ;; uint32 _frame_id
    4
    ;; string _class_name
    4 (length _class_name)
    ;; string _cam
    4 (length _cam)
    ;; float32 _class_confidence
    4
    ;; float32 _detection_confidence
    4
    ;; float32 _x_min
    4
    ;; float32 _y_min
    4
    ;; float32 _x_max
    4
    ;; float32 _y_max
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _timestamp_ns
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestamp_ns (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestamp_ns) (= (length (_timestamp_ns . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestamp_ns . bv) 0) 0) s)
              (write-long (ash (elt (_timestamp_ns . bv) 1) -1) s))
             ((and (class _timestamp_ns) (= (length (_timestamp_ns . bv)) 1)) ;; big1
              (write-long (elt (_timestamp_ns . bv) 0) s)
              (write-long (if (>= _timestamp_ns 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestamp_ns s)(write-long (if (>= _timestamp_ns 0) 0 #xffffffff) s)))
     ;; uint32 _class_id
       (write-long _class_id s)
     ;; uint32 _frame_id
       (write-long _frame_id s)
     ;; string _class_name
       (write-long (length _class_name) s) (princ _class_name s)
     ;; string _cam
       (write-long (length _cam) s) (princ _cam s)
     ;; float32 _class_confidence
       (sys::poke _class_confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _detection_confidence
       (sys::poke _detection_confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x_min
       (sys::poke _x_min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_min
       (sys::poke _y_min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x_max
       (sys::poke _x_max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_max
       (sys::poke _y_max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _timestamp_ns
#+(or :alpha :irix6 :x86_64)
      (setf _timestamp_ns (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestamp_ns (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32 _class_id
     (setq _class_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _frame_id
     (setq _frame_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _class_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _class_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _cam
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _cam (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _class_confidence
     (setq _class_confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _detection_confidence
     (setq _detection_confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x_min
     (setq _x_min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_min
     (setq _y_min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x_max
     (setq _x_max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_max
     (setq _y_max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get computer_msgs::AiDetection :md5sum-) "66b7593eed3e8ef91f597c785c6a914f")
(setf (get computer_msgs::AiDetection :datatype-) "computer_msgs/AiDetection")
(setf (get computer_msgs::AiDetection :definition-)
      "int64 timestamp_ns
uint32 class_id
uint32 frame_id
string class_name
string cam
float32 class_confidence
float32 detection_confidence
float32 x_min
float32 y_min
float32 x_max
float32 y_max

")



(provide :computer_msgs/AiDetection "66b7593eed3e8ef91f597c785c6a914f")


