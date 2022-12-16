
library data.maps;
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:exploress_location/logic/map_data/gps_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:latlong2/latlong.dart' as dist;


part 'maps_bloc.dart';
part 'maps_event.dart';
part 'maps_state.dart';



class MapsData extends Equatable{
  //final Set<Marker>? shopMarkers;
  final GPSPosition currentPosition;

  const MapsData({required this.currentPosition});


  static MapsData empty = MapsData(currentPosition: GPSPosition.empty);

  CameraPosition get currentCameraPosition => CameraPosition(
      target: currentPosition.latLng,
      zoom: 15.0,
  );

  LatLng get currentLatLng => LatLng(
      currentPosition.latLng.latitude,
      currentPosition.latLng.longitude
  );

  //Marker get currentMarker => Marker(markerId: null);

  dist.LatLng get currentLatLng2 => dist.LatLng(
      currentPosition.latLng.latitude,
      currentPosition.latLng.longitude
  );

  @override
  List<Object?> get props => [currentPosition];


}