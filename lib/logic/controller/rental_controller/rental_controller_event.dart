part of 'rental_controller_bloc.dart';

abstract class RentalControllerEvent extends Equatable {
  const RentalControllerEvent();

  @override
  List<Object> get props => [];
}

class RentalStuffInitial extends RentalControllerEvent {
   const RentalStuffInitial();

   StuffRental get stuffRental => SpaceRental.empty;
}
