part of 'rental_controller_bloc.dart';

enum RentalControllerStatus{initial, addingInfo, addingImages, checkingAll}

class RentalControllerState extends Equatable {
  final StuffRental rental;
  final RentalControllerStatus status;
  final bool isCompleted;
  const RentalControllerState._({
    this.rental =  SpaceRental.empty,
    this.status = RentalControllerStatus.initial,
    this.isCompleted = false});
  const RentalControllerState.initial() : this._();
  const RentalControllerState.space(
      SpaceRental spaceRental, {
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(rental: spaceRental, status: status);

  const RentalControllerState.vehicle(
      VehicleRental vehicleRental,{
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(rental: vehicleRental, status: status);

  const RentalControllerState.complete(
      StuffRental rental, {
        RentalControllerStatus status = RentalControllerStatus.checkingAll,
      }) : this._(rental: rental, status: status, isCompleted: true);

  @override
  List<Object> get props => [rental, isCompleted];

  RentalType get rentalType => rental.rentalType;
}



