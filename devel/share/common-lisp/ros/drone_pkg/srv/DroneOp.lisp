; Auto-generated. Do not edit!


(cl:in-package drone_pkg-srv)


;//! \htmlinclude DroneOp-request.msg.html

(cl:defclass <DroneOp-request> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0))
)

(cl:defclass DroneOp-request (<DroneOp-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DroneOp-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DroneOp-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drone_pkg-srv:<DroneOp-request> is deprecated: use drone_pkg-srv:DroneOp-request instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <DroneOp-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drone_pkg-srv:mode-val is deprecated.  Use drone_pkg-srv:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DroneOp-request>) ostream)
  "Serializes a message object of type '<DroneOp-request>"
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DroneOp-request>) istream)
  "Deserializes a message object of type '<DroneOp-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DroneOp-request>)))
  "Returns string type for a service object of type '<DroneOp-request>"
  "drone_pkg/DroneOpRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DroneOp-request)))
  "Returns string type for a service object of type 'DroneOp-request"
  "drone_pkg/DroneOpRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DroneOp-request>)))
  "Returns md5sum for a message object of type '<DroneOp-request>"
  "46e3fbb42467cdb3ed60e9a1d6e7dbc3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DroneOp-request)))
  "Returns md5sum for a message object of type 'DroneOp-request"
  "46e3fbb42467cdb3ed60e9a1d6e7dbc3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DroneOp-request>)))
  "Returns full string definition for message of type '<DroneOp-request>"
  (cl:format cl:nil "int32 mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DroneOp-request)))
  "Returns full string definition for message of type 'DroneOp-request"
  (cl:format cl:nil "int32 mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DroneOp-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DroneOp-request>))
  "Converts a ROS message object to a list"
  (cl:list 'DroneOp-request
    (cl:cons ':mode (mode msg))
))
;//! \htmlinclude DroneOp-response.msg.html

(cl:defclass <DroneOp-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass DroneOp-response (<DroneOp-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DroneOp-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DroneOp-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name drone_pkg-srv:<DroneOp-response> is deprecated: use drone_pkg-srv:DroneOp-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <DroneOp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader drone_pkg-srv:success-val is deprecated.  Use drone_pkg-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DroneOp-response>) ostream)
  "Serializes a message object of type '<DroneOp-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DroneOp-response>) istream)
  "Deserializes a message object of type '<DroneOp-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DroneOp-response>)))
  "Returns string type for a service object of type '<DroneOp-response>"
  "drone_pkg/DroneOpResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DroneOp-response)))
  "Returns string type for a service object of type 'DroneOp-response"
  "drone_pkg/DroneOpResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DroneOp-response>)))
  "Returns md5sum for a message object of type '<DroneOp-response>"
  "46e3fbb42467cdb3ed60e9a1d6e7dbc3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DroneOp-response)))
  "Returns md5sum for a message object of type 'DroneOp-response"
  "46e3fbb42467cdb3ed60e9a1d6e7dbc3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DroneOp-response>)))
  "Returns full string definition for message of type '<DroneOp-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DroneOp-response)))
  "Returns full string definition for message of type 'DroneOp-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DroneOp-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DroneOp-response>))
  "Converts a ROS message object to a list"
  (cl:list 'DroneOp-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'DroneOp)))
  'DroneOp-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'DroneOp)))
  'DroneOp-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DroneOp)))
  "Returns string type for a service object of type '<DroneOp>"
  "drone_pkg/DroneOp")