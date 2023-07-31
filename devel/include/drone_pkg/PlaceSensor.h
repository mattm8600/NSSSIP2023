// Generated by gencpp from file drone_pkg/PlaceSensor.msg
// DO NOT EDIT!


#ifndef DRONE_PKG_MESSAGE_PLACESENSOR_H
#define DRONE_PKG_MESSAGE_PLACESENSOR_H

#include <ros/service_traits.h>


#include <drone_pkg/PlaceSensorRequest.h>
#include <drone_pkg/PlaceSensorResponse.h>


namespace drone_pkg
{

struct PlaceSensor
{

typedef PlaceSensorRequest Request;
typedef PlaceSensorResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct PlaceSensor
} // namespace drone_pkg


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::drone_pkg::PlaceSensor > {
  static const char* value()
  {
    return "92d27cc93d35e7c5066371f928a11ffc";
  }

  static const char* value(const ::drone_pkg::PlaceSensor&) { return value(); }
};

template<>
struct DataType< ::drone_pkg::PlaceSensor > {
  static const char* value()
  {
    return "drone_pkg/PlaceSensor";
  }

  static const char* value(const ::drone_pkg::PlaceSensor&) { return value(); }
};


// service_traits::MD5Sum< ::drone_pkg::PlaceSensorRequest> should match
// service_traits::MD5Sum< ::drone_pkg::PlaceSensor >
template<>
struct MD5Sum< ::drone_pkg::PlaceSensorRequest>
{
  static const char* value()
  {
    return MD5Sum< ::drone_pkg::PlaceSensor >::value();
  }
  static const char* value(const ::drone_pkg::PlaceSensorRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::drone_pkg::PlaceSensorRequest> should match
// service_traits::DataType< ::drone_pkg::PlaceSensor >
template<>
struct DataType< ::drone_pkg::PlaceSensorRequest>
{
  static const char* value()
  {
    return DataType< ::drone_pkg::PlaceSensor >::value();
  }
  static const char* value(const ::drone_pkg::PlaceSensorRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::drone_pkg::PlaceSensorResponse> should match
// service_traits::MD5Sum< ::drone_pkg::PlaceSensor >
template<>
struct MD5Sum< ::drone_pkg::PlaceSensorResponse>
{
  static const char* value()
  {
    return MD5Sum< ::drone_pkg::PlaceSensor >::value();
  }
  static const char* value(const ::drone_pkg::PlaceSensorResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::drone_pkg::PlaceSensorResponse> should match
// service_traits::DataType< ::drone_pkg::PlaceSensor >
template<>
struct DataType< ::drone_pkg::PlaceSensorResponse>
{
  static const char* value()
  {
    return DataType< ::drone_pkg::PlaceSensor >::value();
  }
  static const char* value(const ::drone_pkg::PlaceSensorResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // DRONE_PKG_MESSAGE_PLACESENSOR_H