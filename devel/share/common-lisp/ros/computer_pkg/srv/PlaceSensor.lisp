; Auto-generated. Do not edit!


(cl:in-package computer_pkg-srv)


;//! \htmlinclude PlaceSensor-request.msg.html

(cl:defclass <PlaceSensor-request> (roslisp-msg-protocol:ros-message)
  ((latitude
    :reader latitude
    :initarg :latitude
    :type cl:float
    :initform 0.0)
   (longitude
    :reader longitude
    :initarg :longitude
    :type cl:float
    :initform 0.0)
   (battery
    :reader battery
    :initarg :battery
    :type cl:float
    :initform 0.0))
)

(cl:defclass PlaceSensor-request (<PlaceSensor-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlaceSensor-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlaceSensor-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name computer_pkg-srv:<PlaceSensor-request> is deprecated: use computer_pkg-srv:PlaceSensor-request instead.")))

(cl:ensure-generic-function 'latitude-val :lambda-list '(m))
(cl:defmethod latitude-val ((m <PlaceSensor-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-srv:latitude-val is deprecated.  Use computer_pkg-srv:latitude instead.")
  (latitude m))

(cl:ensure-generic-function 'longitude-val :lambda-list '(m))
(cl:defmethod longitude-val ((m <PlaceSensor-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-srv:longitude-val is deprecated.  Use computer_pkg-srv:longitude instead.")
  (longitude m))

(cl:ensure-generic-function 'battery-val :lambda-list '(m))
(cl:defmethod battery-val ((m <PlaceSensor-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-srv:battery-val is deprecated.  Use computer_pkg-srv:battery instead.")
  (battery m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlaceSensor-request>) ostream)
  "Serializes a message object of type '<PlaceSensor-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'battery))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlaceSensor-request>) istream)
  "Deserializes a message object of type '<PlaceSensor-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'latitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'longitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'battery) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlaceSensor-request>)))
  "Returns string type for a service object of type '<PlaceSensor-request>"
  "computer_pkg/PlaceSensorRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlaceSensor-request)))
  "Returns string type for a service object of type 'PlaceSensor-request"
  "computer_pkg/PlaceSensorRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlaceSensor-request>)))
  "Returns md5sum for a message object of type '<PlaceSensor-request>"
  "92d27cc93d35e7c5066371f928a11ffc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlaceSensor-request)))
  "Returns md5sum for a message object of type 'PlaceSensor-request"
  "92d27cc93d35e7c5066371f928a11ffc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlaceSensor-request>)))
  "Returns full string definition for message of type '<PlaceSensor-request>"
  (cl:format cl:nil "float64 latitude~%float64 longitude~%float32 battery~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlaceSensor-request)))
  "Returns full string definition for message of type 'PlaceSensor-request"
  (cl:format cl:nil "float64 latitude~%float64 longitude~%float32 battery~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlaceSensor-request>))
  (cl:+ 0
     8
     8
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlaceSensor-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PlaceSensor-request
    (cl:cons ':latitude (latitude msg))
    (cl:cons ':longitude (longitude msg))
    (cl:cons ':battery (battery msg))
))
;//! \htmlinclude PlaceSensor-response.msg.html

(cl:defclass <PlaceSensor-response> (roslisp-msg-protocol:ros-message)
  ((target_latitude
    :reader target_latitude
    :initarg :target_latitude
    :type cl:float
    :initform 0.0)
   (target_longitude
    :reader target_longitude
    :initarg :target_longitude
    :type cl:float
    :initform 0.0))
)

(cl:defclass PlaceSensor-response (<PlaceSensor-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlaceSensor-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlaceSensor-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name computer_pkg-srv:<PlaceSensor-response> is deprecated: use computer_pkg-srv:PlaceSensor-response instead.")))

(cl:ensure-generic-function 'target_latitude-val :lambda-list '(m))
(cl:defmethod target_latitude-val ((m <PlaceSensor-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-srv:target_latitude-val is deprecated.  Use computer_pkg-srv:target_latitude instead.")
  (target_latitude m))

(cl:ensure-generic-function 'target_longitude-val :lambda-list '(m))
(cl:defmethod target_longitude-val ((m <PlaceSensor-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader computer_pkg-srv:target_longitude-val is deprecated.  Use computer_pkg-srv:target_longitude instead.")
  (target_longitude m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlaceSensor-response>) ostream)
  "Serializes a message object of type '<PlaceSensor-response>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlaceSensor-response>) istream)
  "Deserializes a message object of type '<PlaceSensor-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_latitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_longitude) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlaceSensor-response>)))
  "Returns string type for a service object of type '<PlaceSensor-response>"
  "computer_pkg/PlaceSensorResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlaceSensor-response)))
  "Returns string type for a service object of type 'PlaceSensor-response"
  "computer_pkg/PlaceSensorResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlaceSensor-response>)))
  "Returns md5sum for a message object of type '<PlaceSensor-response>"
  "92d27cc93d35e7c5066371f928a11ffc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlaceSensor-response)))
  "Returns md5sum for a message object of type 'PlaceSensor-response"
  "92d27cc93d35e7c5066371f928a11ffc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlaceSensor-response>)))
  "Returns full string definition for message of type '<PlaceSensor-response>"
  (cl:format cl:nil "float64 target_latitude~%float64 target_longitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlaceSensor-response)))
  "Returns full string definition for message of type 'PlaceSensor-response"
  (cl:format cl:nil "float64 target_latitude~%float64 target_longitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlaceSensor-response>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlaceSensor-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PlaceSensor-response
    (cl:cons ':target_latitude (target_latitude msg))
    (cl:cons ':target_longitude (target_longitude msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PlaceSensor)))
  'PlaceSensor-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PlaceSensor)))
  'PlaceSensor-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlaceSensor)))
  "Returns string type for a service object of type '<PlaceSensor>"
  "computer_pkg/PlaceSensor")