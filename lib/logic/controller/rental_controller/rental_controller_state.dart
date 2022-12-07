part of 'rental_controller_bloc.dart';

enum RentalControllerStatus{initial, addingInfo, addingImages, checkingAll}

class RentalControllerState extends Equatable {
  final RentalProduct rental;
  final RentalControllerStatus status;
  final bool isCompleted;
  final bool _isMovable;
  const RentalControllerState._({
    this.rental =  RentalSpace.empty,
    this.status = RentalControllerStatus.initial,
    this.isCompleted = false,
    bool isMovable = false, }) : _isMovable = isMovable;
  const RentalControllerState.initial() : this._();
  const RentalControllerState.space(
      RentalSpace spaceRental, {
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(rental: spaceRental, status: status, isMovable: false);

  const RentalControllerState.vehicle(
      RentalVehicle vehicleRental,{
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(rental: vehicleRental, status: status, isMovable: true);

  const RentalControllerState.complete(
      RentalProduct rental, {
        RentalControllerStatus status = RentalControllerStatus.checkingAll,
      }) : this._(
      rental: rental,
      status: status,
      isCompleted: true,
      isMovable: RentalProduct is RentalVehicle);

  bool get isMovable => _isMovable;
  bool get isImmovable => !_isMovable;


  /*const RentalControllerState.modify(): this._(
    isCompleted: true,
    status: RentalControllerStatus.
  );*/

  @override
  List<Object> get props => [rental, isCompleted];

  RentalType get rentalType => rental.rentalType;
}



