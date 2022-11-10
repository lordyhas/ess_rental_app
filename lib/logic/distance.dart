

part of values;

double distance({required LatLng fromLatLng, required LatLng toLatLng}){
  const Distance distance = Distance();

  final double km = distance.as(LengthUnit.Meter, fromLatLng,toLatLng);
  return km/1000;
}
/// this will calculate the distance between two GPS coordinates point
class DistanceBetween {
  /// first GPS coordinates [LatLng] from latlong2 library,
  final LatLng fromLatLng;
  /// second GPS coordinates [LatLng] from latlong2 library,
  final LatLng toLatLng;
  DistanceBetween({required this. fromLatLng, required this. toLatLng});

  final Distance _distance = const Distance();


  double get distanceKiloMeter {
    final double meter = _distance
        .as(LengthUnit.Meter, this.fromLatLng, this.toLatLng);
    return meter/1000;
  }
  double get distanceKM => distanceKiloMeter;

  double get distanceMeter {
    final double meter = _distance
        .as(LengthUnit.Meter, this.fromLatLng, this.toLatLng);
    return meter;
  }

}