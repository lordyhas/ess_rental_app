part of data.maps;

enum LocationStatus {unknown, loaded, error}

class MapsState extends Equatable {
  MapsState._({
    this.status = LocationStatus.unknown,
    MapsData? mapsData,
  }): this.maps = mapsData ?? MapsData.empty;

  final LocationStatus status;
  final MapsData maps;

  MapsState.unknown() : this._();
  MapsState.loaded(MapsData maps) : this._(status: LocationStatus.loaded, mapsData: maps);
  MapsState.error() : this._(status: LocationStatus.error);


  @override
  List<Object> get props => [status,maps];
}



