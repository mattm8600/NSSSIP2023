; Auto-generated. Do not edit!


(cl:in-package computer_pkg-msg)


;//! \htmlinclude AiDetection.msg.html

(cl:defclass <AiDetection> (roslisp-msg-protocol:ros-message)
  ((timestamp_ns
    :reader timestamp_ns
    :initarg :timestamp_ns
    :type cl:integer
    :initform 0)
   (class_id
    :reader class_id
    :initarg :class_id
    :type cl:integer
    :initform 0)
   (frame_id
    :reader frame_id
    :initarg :frame_id
    :type cl:integer
    :initform 0)
   (class_name
    :reader class_name
    :initarg :class_name
    :type cl:string
    :initform "")
   (cam
    :reader cam
    :initarg :cam
    :type cl:string
    :initform "")
   (class_confidence
    :reader class_confidence
    :initarg :class_confidence
    :type cl:float
    :initform 0.0)
   (detection_confidence
    :reader detection_confidence
    :initarg :detection_confidence
    :type cl:float
    :initform 0.0)
   (x_min
    :reader x_min
    :initarg :x_min
    :type cl:float
    :initform 0.0)
   (y_min
    :reader y_min
    :initarg :y_min
    :type cl:float
    :initform 0.0)
   (x_max
    :reader x_max
    :initarg :x_max
    :type cl:float
    :initform 0.0)
   (y_max
    :reader y_max
    :initarg :y_max
    :type cl:float
    :initform 0.0))
)

(cl:defclass AiDetection (<AiDetection>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AiDetection>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AiDetection)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name computer_pkg-msg:<AiDetection> is deprecated: use computer_pkg-msg:AiDetection instead.")))

(cl:ensure-generic-function 'timestamp_ns-val :lambda-list '(m))
(cl:defmethod timestamp_ns-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:timestamp_ns-val is deprecated.  Use computer_pkg-msg:timestamp_ns instead.")
  (timestamp_ns m))

(cl:ensure-generic-function 'class_id-val :lambda-list '(m))
(cl:defmethod class_id-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:class_id-val is deprecated.  Use computer_pkg-msg:class_id instead.")
  (class_id m))

(cl:ensure-generic-function 'frame_id-val :lambda-list '(m))
(cl:defmethod frame_id-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:frame_id-val is deprecated.  Use computer_pkg-msg:frame_id instead.")
  (frame_id m))

(cl:ensure-generic-function 'class_name-val :lambda-list '(m))
(cl:defmethod class_name-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:class_name-val is deprecated.  Use computer_pkg-msg:class_name instead.")
  (class_name m))

(cl:ensure-generic-function 'cam-val :lambda-list '(m))
(cl:defmethod cam-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:cam-val is deprecated.  Use computer_pkg-msg:cam instead.")
  (cam m))

(cl:ensure-generic-function 'class_confidence-val :lambda-list '(m))
(cl:defmethod class_confidence-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:class_confidence-val is deprecated.  Use computer_pkg-msg:class_confidence instead.")
  (class_confidence m))

(cl:ensure-generic-function 'detection_confidence-val :lambda-list '(m))
(cl:defmethod detection_confidence-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:detection_confidence-val is deprecated.  Use computer_pkg-msg:detection_confidence instead.")
  (detection_confidence m))

(cl:ensure-generic-function 'x_min-val :lambda-list '(m))
(cl:defmethod x_min-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:x_min-val is deprecated.  Use computer_pkg-msg:x_min instead.")
  (x_min m))

(cl:ensure-generic-function 'y_min-val :lambda-list '(m))
(cl:defmethod y_min-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:y_min-val is deprecated.  Use computer_pkg-msg:y_min instead.")
  (y_min m))

(cl:ensure-generic-function 'x_max-val :lambda-list '(m))
(cl:defmethod x_max-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:x_max-val is deprecated.  Use computer_pkg-msg:x_max instead.")
  (x_max m))

(cl:ensure-generic-function 'y_max-val :lambda-list '(m))
(cl:defmethod y_max-val ((m <AiDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-msg:y_max-val is deprecated.  Use computer_pkg-msg:y_max instead.")
  (y_max m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AiDetection>) ostream)
  "Serializes a message object of type '<AiDetection>"
  (cl:let* ((signed (cl:slot-value msg 'timestamp_ns)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'class_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'class_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'class_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'class_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frame_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frame_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'frame_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'frame_id)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'class_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'class_name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'cam))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'cam))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'class_confidence))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'detection_confidence))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AiDetection>) istream)
  "Deserializes a message object of type '<AiDetection>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timestamp_ns) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'class_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'class_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'class_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'class_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frame_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frame_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'frame_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'frame_id)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'class_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'class_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'cam) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'cam) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'class_confidence) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'detection_confidence) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_max) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_max) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AiDetection>)))
  "Returns string type for a message object of type '<AiDetection>"
  "computer_pkg/AiDetection")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AiDetection)))
  "Returns string type for a message object of type 'AiDetection"
  "computer_pkg/AiDetection")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AiDetection>)))
  "Returns md5sum for a message object of type '<AiDetection>"
  "66b7593eed3e8ef91f597c785c6a914f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AiDetection)))
  "Returns md5sum for a message object of type 'AiDetection"
  "66b7593eed3e8ef91f597c785c6a914f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AiDetection>)))
  "Returns full string definition for message of type '<AiDetection>"
  (cl:format cl:nil "int64 timestamp_ns~%uint32 class_id~%uint32 frame_id~%string class_name~%string cam~%float32 class_confidence~%float32 detection_confidence~%float32 x_min~%float32 y_min~%float32 x_max~%float32 y_max~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AiDetection)))
  "Returns full string definition for message of type 'AiDetection"
  (cl:format cl:nil "int64 timestamp_ns~%uint32 class_id~%uint32 frame_id~%string class_name~%string cam~%float32 class_confidence~%float32 detection_confidence~%float32 x_min~%float32 y_min~%float32 x_max~%float32 y_max~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AiDetection>))
  (cl:+ 0
     8
     4
     4
     4 (cl:length (cl:slot-value msg 'class_name))
     4 (cl:length (cl:slot-value msg 'cam))
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AiDetection>))
  "Converts a ROS message object to a list"
  (cl:list 'AiDetection
    (cl:cons ':timestamp_ns (timestamp_ns msg))
    (cl:cons ':class_id (class_id msg))
    (cl:cons ':frame_id (frame_id msg))
    (cl:cons ':class_name (class_name msg))
    (cl:cons ':cam (cam msg))
    (cl:cons ':class_confidence (class_confidence msg))
    (cl:cons ':detection_confidence (detection_confidence msg))
    (cl:cons ':x_min (x_min msg))
    (cl:cons ':y_min (y_min msg))
    (cl:cons ':x_max (x_max msg))
    (cl:cons ':y_max (y_max msg))
))
