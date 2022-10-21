part of data.maps;

abstract class MapsEvent extends Equatable {
  const MapsEvent();
  @override
  List<Object> get props => [];
}

class MapsDataLoad extends MapsEvent{
  const MapsDataLoad(this.location);

  final MapsData location;

  @override
  List<Object> get props => [location];
}

class MapsDataChanged extends MapsEvent{
  const MapsDataChanged(this.location);

  final MapsData location;

  @override
  List<Object> get props => [location];
}


