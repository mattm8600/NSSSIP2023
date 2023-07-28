// Auto-generated. Do not edit!

// (in-package drone_pkg.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class PlaceSensorRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.latitude = null;
      this.longitude = null;
      this.battery = null;
    }
    else {
      if (initObj.hasOwnProperty('latitude')) {
        this.latitude = initObj.latitude
      }
      else {
        this.latitude = 0.0;
      }
      if (initObj.hasOwnProperty('longitude')) {
        this.longitude = initObj.longitude
      }
      else {
        this.longitude = 0.0;
      }
      if (initObj.hasOwnProperty('battery')) {
        this.battery = initObj.battery
      }
      else {
        this.battery = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PlaceSensorRequest
    // Serialize message field [latitude]
    bufferOffset = _serializer.float64(obj.latitude, buffer, bufferOffset);
    // Serialize message field [longitude]
    bufferOffset = _serializer.float64(obj.longitude, buffer, bufferOffset);
    // Serialize message field [battery]
    bufferOffset = _serializer.float32(obj.battery, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PlaceSensorRequest
    let len;
    let data = new PlaceSensorRequest(null);
    // Deserialize message field [latitude]
    data.latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [longitude]
    data.longitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [battery]
    data.battery = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 20;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drone_pkg/PlaceSensorRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fad2e88560e107354b953b24a23d72d5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 latitude
    float64 longitude
    float32 battery
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PlaceSensorRequest(null);
    if (msg.latitude !== undefined) {
      resolved.latitude = msg.latitude;
    }
    else {
      resolved.latitude = 0.0
    }

    if (msg.longitude !== undefined) {
      resolved.longitude = msg.longitude;
    }
    else {
      resolved.longitude = 0.0
    }

    if (msg.battery !== undefined) {
      resolved.battery = msg.battery;
    }
    else {
      resolved.battery = 0.0
    }

    return resolved;
    }
};

class PlaceSensorResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.target_latitude = null;
      this.target_longitude = null;
    }
    else {
      if (initObj.hasOwnProperty('target_latitude')) {
        this.target_latitude = initObj.target_latitude
      }
      else {
        this.target_latitude = 0.0;
      }
      if (initObj.hasOwnProperty('target_longitude')) {
        this.target_longitude = initObj.target_longitude
      }
      else {
        this.target_longitude = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PlaceSensorResponse
    // Serialize message field [target_latitude]
    bufferOffset = _serializer.float64(obj.target_latitude, buffer, bufferOffset);
    // Serialize message field [target_longitude]
    bufferOffset = _serializer.float64(obj.target_longitude, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PlaceSensorResponse
    let len;
    let data = new PlaceSensorResponse(null);
    // Deserialize message field [target_latitude]
    data.target_latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_longitude]
    data.target_longitude = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drone_pkg/PlaceSensorResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3b1f2bd693b2ac93950ddc44a5453ced';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 target_latitude
    float64 target_longitude
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PlaceSensorResponse(null);
    if (msg.target_latitude !== undefined) {
      resolved.target_latitude = msg.target_latitude;
    }
    else {
      resolved.target_latitude = 0.0
    }

    if (msg.target_longitude !== undefined) {
      resolved.target_longitude = msg.target_longitude;
    }
    else {
      resolved.target_longitude = 0.0
    }

    return resolved;
    }
};

module.exports = {
  Request: PlaceSensorRequest,
  Response: PlaceSensorResponse,
  md5sum() { return '92d27cc93d35e7c5066371f928a11ffc'; },
  datatype() { return 'drone_pkg/PlaceSensor'; }
};
