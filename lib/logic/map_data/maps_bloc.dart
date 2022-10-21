part of data.maps;

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsState.unknown());



  @override
  Stream<MapsState> mapEventToState(
    MapsEvent event,
  ) async* {

    if(event is MapsDataLoad){
      yield _updateToCart(event);
    }

  }

  MapsState _updateToCart(MapsDataLoad event) {
    return MapsState.loaded(event.location);
  }

  void load({required GPSPosition position}) =>
      add(MapsDataLoad(MapsData(currentPosition: position,)));


  @override
  Future<void> close() {
    return super.close();
  }


}
