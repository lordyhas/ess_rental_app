part of data.model;
/*
class VehicleRental extends StuffRental{
  final dynamic id;
  final String mark;
  final int seat;
  final VehicleRentalType vehicleType;
  final String description;
  final dynamic owner;
  final List<dynamic> images;
  final int? door;
  final AddressData? address;
  final maps.LatLng? coordinates;
  final bool isTaken;



  @override
  RentalType get rentalType => RentalType.vehicle;

//<editor-fold desc="Data Methods">

  const VehicleRental({
    required this.id,
    required this.mark,
    required this.vehicleType,
    required this.description,
    this.owner,
    this.images = const [],
    this.seat = 1,
    this.door,
    this.address,
    this.coordinates,
    this.isTaken = false,
  }): assert(seat < 1,"a rental vehicle can't have less than 1 seat");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is VehicleRental &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              mark == other.mark &&
              seat == other.seat &&
              vehicleType == other.vehicleType &&
              description == other.description &&
              owner == other.owner &&
              images == other.images &&
              door == other.door &&
              address == other.address &&
              coordinates == other.coordinates &&
              isTaken == other.isTaken);

  @override
  int get hashCode =>
      id.hashCode ^
      mark.hashCode ^
      seat.hashCode ^
      vehicleType.hashCode ^
      description.hashCode ^
      owner.hashCode ^
      images.hashCode ^
      door.hashCode ^
      address.hashCode ^
      coordinates.hashCode ^
      isTaken.hashCode;

  @override
  String toString() {
    return 'VehicleRental{ '
        'id: $id, mark: $mark, seat: $seat, vehicleType: $vehicleType, '
        'description: $description, owner: $owner, images: $images, '
        'door: $door, address: $address, coordinates: $coordinates, '
        'isTaken: $isTaken,}';
  }

  VehicleRental copyWith({
    dynamic id,
    String? mark,
    int? seat,
    VehicleRentalType? vehicleType,
    String? description,
    dynamic owner,
    List<dynamic>? images,
    int? door,
    AddressData? address,
    maps.LatLng? coordinates,
    bool? isTaken,
  }) {
    return VehicleRental(
      id: id ?? this.id,
      mark: mark ?? this.mark,
      seat: seat ?? this.seat,
      vehicleType: vehicleType ?? this.vehicleType,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      images: images ?? this.images,
      door: door ?? this.door,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      isTaken: isTaken ?? this.isTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mark': mark,
      'seat': seat,
      'vehicleType': vehicleType,
      'description': description,
      'owner': owner,
      'images': images,
      'door': door,
      'address': address,
      'coordinates': coordinates,
      'isTaken': isTaken,
    };
  }

  factory VehicleRental.fromMap(Map<String, dynamic> map) {
    return VehicleRental(
      id: map['id'] as dynamic,
      mark: map['mark'] as String,
      seat: map['seat'] as int,
      vehicleType: map['vehicleType'] as VehicleRentalType,
      description: map['description'] as String,
      owner: map['owner'] as dynamic,
      images: map['images'] as List<dynamic>,
      door: map['door'] as int,
      address: map['address'] as AddressData,
      coordinates: map['coordinates'] as maps.LatLng,
      isTaken: map['isTaken'] as bool,
    );
  }

//</editor-fold>
}

*/

class VehicleRental extends StuffRental {
  final dynamic id;
  final String mark;
  final String description;
  final VehicleRentalType vehicleType;


  final dynamic owner;
  final int? door;
  final int seat;
  final List<dynamic> images;
  final AddressData? address;
  final maps.LatLng? coordinates;
  final bool isTaken;

  const VehicleRental({
    required this.mark,
    required this.id,
    required this.description,
    required this.vehicleType,
    this.door,
    this.owner,
    this.seat = 1,
    this.images = const [],
    this.address,
    this.coordinates,
    this.isTaken = false,
  });


  static const empty = VehicleRental(
      id: '',
      mark: '',
      description: '',
      vehicleType: VehicleRentalType.B
  );


  /// Convenience getter to determine whether the current [VehicleRental] is empty.
  bool get isEmpty => this == VehicleRental.empty;

  /// Convenience getter to determine whether the current [VehicleRental] is not empty.
  bool get isNotEmpty => this != VehicleRental.empty;

  @override
  RentalType get rentalType => RentalType.vehicle;



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is VehicleRental &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              mark == other.mark &&
              seat == other.seat &&
              vehicleType == other.vehicleType &&
              description == other.description &&
              owner == other.owner &&
              images == other.images &&
              door == other.door &&
              address == other.address &&
              coordinates == other.coordinates &&
              isTaken == other.isTaken);

  @override
  int get hashCode =>
      id.hashCode ^
      mark.hashCode ^
      seat.hashCode ^
      vehicleType.hashCode ^
      description.hashCode ^
      owner.hashCode ^
      images.hashCode ^
      door.hashCode ^
      address.hashCode ^
      coordinates.hashCode ^
      isTaken.hashCode;

  @override
  String toString() {
    return 'VehicleRental{ '
        'id: $id, mark: $mark, seat: $seat, vehicleType: $vehicleType, '
        'description: $description, owner: $owner, images: $images, '
        'door: $door, address: $address, coordinates: $coordinates, '
        'isTaken: $isTaken,}';
  }

  VehicleRental copyWith({
    dynamic id,
    String? mark,
    int? seat,
    VehicleRentalType? vehicleType,
    String? description,
    dynamic owner,
    List<dynamic>? images,
    int? door,
    AddressData? address,
    maps.LatLng? coordinates,
    bool? isTaken,
  }) {
    return VehicleRental(
      id: id ?? this.id,
      mark: mark ?? this.mark,
      seat: seat ?? this.seat,
      vehicleType: vehicleType ?? this.vehicleType,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      images: images ?? this.images,
      door: door ?? this.door,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      isTaken: isTaken ?? this.isTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mark': mark,
      'seat': seat,
      'vehicleType': vehicleType,
      'description': description,
      'owner': owner,
      'images': images,
      'door': door,
      'address': address,
      'coordinates': coordinates,
      'isTaken': isTaken,
    };
  }

  factory VehicleRental.fromMap(Map<String, dynamic> map) {
    return VehicleRental(
      id: map['id'] as dynamic,
      mark: map['mark'] as String,
      seat: map['seat'] as int,
      vehicleType: map['vehicleType'] as VehicleRentalType,
      description: map['description'] as String,
      owner: map['owner'] as dynamic,
      images: map['images'] as List<dynamic>,
      door: map['door'] as int,
      address: map['address'] as AddressData,
      coordinates: map['coordinates'] as maps.LatLng,
      isTaken: map['isTaken'] as bool,
    );
  }

}