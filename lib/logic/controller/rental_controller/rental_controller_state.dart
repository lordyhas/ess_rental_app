part of 'rental_controller_bloc.dart';

enum RentalControllerStatus{initial, addingInfo, addingImages, checkingAll}

class RentalControllerState extends Equatable {
  final RentalSpace _space;
  final RentalVehicle _vehicle;
  final RentalControllerStatus status;
  final bool isCompleted;
  final bool _isMovable;

  const RentalControllerState._({
    RentalSpace space =  RentalSpace.empty,
    RentalVehicle vehicle = RentalVehicle.empty,
    this.status = RentalControllerStatus.initial,
    this.isCompleted = false,
    bool isMovable = false,
  }) :  _isMovable = isMovable,
        _space = space,
        _vehicle = vehicle;

  const RentalControllerState.initial() : this._();

  const RentalControllerState.space(
      RentalSpace spaceRental, {
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(space: spaceRental, status: status, isMovable: false);

  const RentalControllerState.vehicle(
      RentalVehicle vehicleRental,{
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(vehicle: vehicleRental, status: status, isMovable: true);

  const RentalControllerState.complete(rental, {
        RentalControllerStatus status = RentalControllerStatus.checkingAll,
      }) : this._(
      space: rental is RentalSpace ? rental : RentalSpace.empty,
      vehicle: rental is RentalVehicle ? rental : RentalVehicle.empty,
      status: status,
      isCompleted: true,
      isMovable: rental is RentalVehicle);

  bool get isMovable => _isMovable;
  bool get isImmovable => !_isMovable;

  RentalProduct get rental => _isMovable ? _vehicle  : _space;
  RentalVehicle get vehicle =>  _vehicle;
  RentalSpace get space =>  _space;




  /*const RentalControllerState.modify(): this._(
    isCompleted: true,
    status: RentalControllerStatus.
  );*/

  @override
  List<Object> get props => [rental, isCompleted];

  RentalType get rentalType => rental.rentalType;
}



