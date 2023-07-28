// Auto-generated. Do not edit!

// (in-package computer_pkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class AiDetection {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.timestamp_ns = null;
      this.class_id = null;
      this.frame_id = null;
      this.class_name = null;
      this.cam = null;
      this.class_confidence = null;
      this.detection_confidence = null;
      this.x_min = null;
      this.y_min = null;
      this.x_max = null;
      this.y_max = null;
    }
    else {
      if (initObj.hasOwnProperty('timestamp_ns')) {
        this.timestamp_ns = initObj.timestamp_ns
      }
      else {
        this.timestamp_ns = 0;
      }
      if (initObj.hasOwnProperty('class_id')) {
        this.class_id = initObj.class_id
      }
      else {
        this.class_id = 0;
      }
      if (initObj.hasOwnProperty('frame_id')) {
        this.frame_id = initObj.frame_id
      }
      else {
        this.frame_id = 0;
      }
      if (initObj.hasOwnProperty('class_name')) {
        this.class_name = initObj.class_name
      }
      else {
        this.class_name = '';
      }
      if (initObj.hasOwnProperty('cam')) {
        this.cam = initObj.cam
      }
      else {
        this.cam = '';
      }
      if (initObj.hasOwnProperty('class_confidence')) {
        this.class_confidence = initObj.class_confidence
      }
      else {
        this.class_confidence = 0.0;
      }
      if (initObj.hasOwnProperty('detection_confidence')) {
        this.detection_confidence = initObj.detection_confidence
      }
      else {
        this.detection_confidence = 0.0;
      }
      if (initObj.hasOwnProperty('x_min')) {
        this.x_min = initObj.x_min
      }
      else {
        this.x_min = 0.0;
      }
      if (initObj.hasOwnProperty('y_min')) {
        this.y_min = initObj.y_min
      }
      else {
        this.y_min = 0.0;
      }
      if (initObj.hasOwnProperty('x_max')) {
        this.x_max = initObj.x_max
      }
      else {
        this.x_max = 0.0;
      }
      if (initObj.hasOwnProperty('y_max')) {
        this.y_max = initObj.y_max
      }
      else {
        this.y_max = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AiDetection
    // Serialize message field [timestamp_ns]
    bufferOffset = _serializer.int64(obj.timestamp_ns, buffer, bufferOffset);
    // Serialize message field [class_id]
    bufferOffset = _serializer.uint32(obj.class_id, buffer, bufferOffset);
    // Serialize message field [frame_id]
    bufferOffset = _serializer.uint32(obj.frame_id, buffer, bufferOffset);
    // Serialize message field [class_name]
    bufferOffset = _serializer.string(obj.class_name, buffer, bufferOffset);
    // Serialize message field [cam]
    bufferOffset = _serializer.string(obj.cam, buffer, bufferOffset);
    // Serialize message field [class_confidence]
    bufferOffset = _serializer.float32(obj.class_confidence, buffer, bufferOffset);
    // Serialize message field [detection_confidence]
    bufferOffset = _serializer.float32(obj.detection_confidence, buffer, bufferOffset);
    // Serialize message field [x_min]
    bufferOffset = _serializer.float32(obj.x_min, buffer, bufferOffset);
    // Serialize message field [y_min]
    bufferOffset = _serializer.float32(obj.y_min, buffer, bufferOffset);
    // Serialize message field [x_max]
    bufferOffset = _serializer.float32(obj.x_max, buffer, bufferOffset);
    // Serialize message field [y_max]
    bufferOffset = _serializer.float32(obj.y_max, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AiDetection
    let len;
    let data = new AiDetection(null);
    // Deserialize message field [timestamp_ns]
    data.timestamp_ns = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [class_id]
    data.class_id = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [frame_id]
    data.frame_id = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [class_name]
    data.class_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [cam]
    data.cam = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [class_confidence]
    data.class_confidence = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [detection_confidence]
    data.detection_confidence = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [x_min]
    data.x_min = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y_min]
    data.y_min = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [x_max]
    data.x_max = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y_max]
    data.y_max = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.class_name);
    length += _getByteLength(object.cam);
    return length + 48;
  }

  static datatype() {
    // Returns string type for a message object
    return 'computer_pkg/AiDetection';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '66b7593eed3e8ef91f597c785c6a914f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int64 timestamp_ns
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AiDetection(null);
    if (msg.timestamp_ns !== undefined) {
      resolved.timestamp_ns = msg.timestamp_ns;
    }
    else {
      resolved.timestamp_ns = 0
    }

    if (msg.class_id !== undefined) {
      resolved.class_id = msg.class_id;
    }
    else {
      resolved.class_id = 0
    }

    if (msg.frame_id !== undefined) {
      resolved.frame_id = msg.frame_id;
    }
    else {
      resolved.frame_id = 0
    }

    if (msg.class_name !== undefined) {
      resolved.class_name = msg.class_name;
    }
    else {
      resolved.class_name = ''
    }

    if (msg.cam !== undefined) {
      resolved.cam = msg.cam;
    }
    else {
      resolved.cam = ''
    }

    if (msg.class_confidence !== undefined) {
      resolved.class_confidence = msg.class_confidence;
    }
    else {
      resolved.class_confidence = 0.0
    }

    if (msg.detection_confidence !== undefined) {
      resolved.detection_confidence = msg.detection_confidence;
    }
    else {
      resolved.detection_confidence = 0.0
    }

    if (msg.x_min !== undefined) {
      resolved.x_min = msg.x_min;
    }
    else {
      resolved.x_min = 0.0
    }

    if (msg.y_min !== undefined) {
      resolved.y_min = msg.y_min;
    }
    else {
      resolved.y_min = 0.0
    }

    if (msg.x_max !== undefined) {
      resolved.x_max = msg.x_max;
    }
    else {
      resolved.x_max = 0.0
    }

    if (msg.y_max !== undefined) {
      resolved.y_max = msg.y_max;
    }
    else {
      resolved.y_max = 0.0
    }

    return resolved;
    }
};

module.exports = AiDetection;
