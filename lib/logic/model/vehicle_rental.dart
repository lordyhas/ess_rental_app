part of data.model;

class RentalVehicle extends RentalProduct {
  final dynamic id;
  final String mark;
  final String description;
  final RentalVehicleType vehicleType;


  final dynamic owner;
  final int? door;
  final int seat;
  final List<dynamic> images;
  final AddressData? address;
  final maps.LatLng? coordinates;
  final bool isTaken;
  final int? price;


  const RentalVehicle({
    required this.mark,
    required this.id,
    required this.description,
    required this.vehicleType,
    required this.price,

    this.door,
    this.owner,
    this.seat = 1,
    this.images = const [],
    this.address,
    this.coordinates,
    this.isTaken = false,
  });


  static const empty = RentalVehicle(
      id: '',
      mark: '',
      description: '',
      price: null,
      vehicleType: RentalVehicleType.unknown
  );


  /// Convenience getter to determine whether the
  /// current [RentalVehicle] is empty.
  bool get isEmpty => this == RentalVehicle.empty;

  /// Convenience getter to determine whether the
  /// current [RentalVehicle] is not empty.
  bool get isNotEmpty => this != RentalVehicle.empty;

  @override
  RentalType get rentalType => RentalType.vehicle;



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is RentalVehicle &&
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
              isTaken == other.isTaken &&
              price == other.price
          );

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
        'price: $price, description: $description, owner: $owner, '
        'images: $images, door: $door, address: $address, '
        'coordinates: $coordinates, isTaken: $isTaken,}';
  }

  @override
  RentalVehicle copyWith({
    dynamic id,
    String? mark,
    int? seat,
    int? price,
    RentalVehicleType? vehicleType,
    String? description,
    dynamic owner,
    List<dynamic>? images,
    int? door,
    AddressData? address,
    maps.LatLng? coordinates,
    bool? isTaken,
  }) {
    return RentalVehicle(
      id: id ?? this.id,
      mark: mark ?? this.mark,
      seat: seat ?? this.seat,
      price: price ?? this.price,
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
      'price': price,
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

  factory RentalVehicle.fromMap(Map<String, dynamic> map) {
    return RentalVehicle(
      id: map['id'] as dynamic,
      mark: map['mark'] as String,
      seat: map['seat'] as int,
      price: map['price'] as int,
      vehicleType: map['vehicleType'] as RentalVehicleType,
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