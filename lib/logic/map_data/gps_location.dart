
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GPSLocation {


  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<GPSPosition> myCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error("Location permissions are permanently "
                "denied, we cannot request permissions.");
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return (await Geolocator.getCurrentPosition()).toGPSPosition();
  }


}

class GPSPosition extends Position implements Equatable{

   GPSPosition({
    required this.latLng,
    required this.timestamp,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.speedAccuracy,
    this.floor,
    this.isMocked = false,
  }) : super(
    latitude: latLng.latitude,
    longitude: latLng.longitude,
    timestamp: timestamp,
    accuracy: accuracy,
    altitude: altitude,
    heading: heading,
    speed: speed,
    speedAccuracy: speedAccuracy,

  );

  /// A pair of latitude and longitude coordinates, stored as degrees.
  final LatLng latLng;
  /// The time at which this position was determined.
  final DateTime? timestamp;

  /// The altitude of the device in meters.
  ///
  /// The altitude is not available on all devices. In these cases the returned
  /// value is 0.0.
  final double altitude;

  /// The estimated horizontal accuracy of the position in meters.
  ///
  /// The accuracy is not available on all devices. In these cases the value is
  /// 0.0.
  final double accuracy;

  /// The heading in which the device is traveling in degrees.
  ///
  /// The heading is not available on all devices. In these cases the value is
  /// 0.0.
  final double heading;

  /// The floor specifies the floor of the building on which the device is
  /// located.
  ///
  /// The floor property is only available on iOS and only when the information
  /// is available. In all other cases this value will be null.
  final int? floor;

  /// The speed at which the devices is traveling in meters per second over
  /// ground.
  ///
  /// The speed is not available on all devices. In these cases the value is
  /// 0.0.
   final double speed;



   /// The estimated speed accuracy of this position, in meters per second.
   ///
   /// The speedAccuracy is not available on all devices. In these cases the
   /// value is 0.0.
   final double speedAccuracy;

   /// Will be true on Android (starting from API lvl 18) when the location came
   /// from the mocked provider.
   ///
   /// On iOS this value will always be false.
   final bool isMocked;



   /// Converts the supplied [Map] to an instance of the [Position] class.
  static GPSPosition fromMap(dynamic message) {
    final Map<dynamic, dynamic> positionMap = message;

    if (!positionMap.containsKey('latitude')) {
      throw ArgumentError.value(positionMap, 'positionMap',
          'The supplied map doesn\'t contain the mandatory key `latitude`.');
    }

    if (!positionMap.containsKey('longitude')) {
      throw ArgumentError.value(positionMap, 'positionMap',
          'The supplied map doesn\'t contain the mandatory key `longitude`.');
    }

    final timestamp = positionMap['timestamp'] != null
        ? DateTime.fromMillisecondsSinceEpoch(positionMap['timestamp'].toInt(),
        isUtc: true)
        : null;

    return GPSPosition(
      latLng: LatLng(positionMap['latitude'],positionMap['longitude']),
      //latitude: positionMap['latitude'],
      //longitude: positionMap['longitude'],
      timestamp: timestamp,
      altitude: positionMap['altitude'] ?? 0.0,
      accuracy: positionMap['accuracy'] ?? 0.0,
      heading: positionMap['heading'] ?? 0.0,
      floor: positionMap['floor'],
      speed: positionMap['speed'] ?? 0.0,
      speedAccuracy: positionMap['speed_accuracy'] ?? 0.0,
      isMocked: positionMap['is_mocked'] ?? false,
    );
  }

  static GPSPosition empty = GPSPosition(
    latLng: LatLng(0.0,0.0),
    //latitude: positionMap['latitude'],
    //longitude: positionMap['longitude'],
    timestamp: null,
    altitude: 0.0,
    accuracy: 0.0,
    heading: 0.0,
    floor: null,
    speed: 0.0,
    speedAccuracy: 0.0,
    isMocked: false,
  );

  @override
  List<Object?> get props => [
    latLng, altitude, accuracy, heading,
    floor, speed, speedAccuracy, isMocked];

  @override
  bool? get stringify => null;


}

extension on Position{
  GPSPosition toGPSPosition(){
    return GPSPosition(
      latLng: LatLng(this.latitude, this.longitude),
      timestamp: this.timestamp,
      accuracy: this.accuracy,
      altitude: this.altitude,
      heading: this.heading,
      speed: this.speed,
      speedAccuracy: this.speedAccuracy,
      floor: this.floor,
      isMocked: this.isMocked,
    );
  }
}