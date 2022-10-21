
library data.maps;
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:exploress_location/logic/map_data/gps_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:latlong2/latlong.dart' as dist;


part 'maps_bloc.dart';
part 'maps_event.dart';
part 'maps_state.dart';



class MapsData extends Equatable{
  //final Set<Marker>? shopMarkers;
  final GPSPosition currentPosition;

  MapsData({required this.currentPosition});


  static MapsData empty = MapsData(currentPosition: GPSPosition.empty);

  CameraPosition get currentCameraPosition => CameraPosition(
      target: this.currentPosition.latLng,
      zoom: 15.0,
  );

  LatLng get currentLatLng => LatLng(
      this.currentPosition.latLng.latitude,
      this.currentPosition.latLng.longitude
  );

  //Marker get currentMarker => Marker(markerId: null);

  dist.LatLng get currentLatLngFromDistance => dist.LatLng(
      this.currentPosition.latLng.latitude,
      this.currentPosition.latLng.longitude
  );

  @override
  List<Object?> get props => [currentPosition];


}