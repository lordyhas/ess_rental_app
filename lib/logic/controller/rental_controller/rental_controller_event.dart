part of 'rental_controller_bloc.dart';

abstract class RentalControllerEvent extends Equatable {
  const RentalControllerEvent();

  @override
  List<Object> get props => [];
}



class SpaceRentalPassed extends RentalControllerEvent {
  final SpaceRental rental;

  const SpaceRentalPassed(this.rental);
  @override
  List<Object> get props => [rental];
}

class SpaceRentalImaged extends RentalControllerEvent {
  final SpaceRental rental;

  const SpaceRentalImaged(this.rental);
  @override
  List<Object> get props => [rental];
}

class SpaceRentalCompleted extends RentalControllerEvent {
  final SpaceRental rental;

  const SpaceRentalCompleted(this.rental);

  @override
  List<Object> get props => [rental];
}



class VehicleRentalPassed extends RentalControllerEvent {
  final VehicleRental rental;

  const VehicleRentalPassed(this.rental);

  @override
  List<Object> get props => [rental];
}

class VehicleRentalImaged extends RentalControllerEvent {
  final VehicleRental rental;

  const VehicleRentalImaged(this.rental);

  @override
  List<Object> get props => [rental];
}

class VehicleRentalCompleted extends RentalControllerEvent {
  final VehicleRental rental;

  const VehicleRentalCompleted(this.rental);

  @override
  List<Object> get props => [rental];
}
