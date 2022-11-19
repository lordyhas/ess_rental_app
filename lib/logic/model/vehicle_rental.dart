part of data.model;

class VehicleRental extends StuffRental{
  final Object id;
  final String mark;
  final int seat;
  final VehicleRentalType vehicleType;
  final String description;
  final dynamic owner;
  final List<dynamic> imageUrl;
  final int? door;
  final AddressData? address;
  final maps.LatLng? coordinates;


  @override
  RentalType get rentalType => RentalType.vehicle;

//<editor-fold desc="Data Methods">

  const VehicleRental({
    required this.id,
    required this.mark,
    required this.vehicleType,
    required this.description,
    required this.owner,
    required this.imageUrl,
    this.seat = 1,
    this.door,
    this.address,
    this.coordinates,
  }) : assert(seat < 1,"a rental vehicle can't have less than 1 seat");

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
          imageUrl == other.imageUrl &&
          door == other.door &&
          address == other.address &&
          coordinates == other.coordinates);

  @override
  int get hashCode =>
      id.hashCode ^
      mark.hashCode ^
      seat.hashCode ^
      vehicleType.hashCode ^
      description.hashCode ^
      owner.hashCode ^
      imageUrl.hashCode ^
      door.hashCode ^
      address.hashCode ^
      coordinates.hashCode;

  @override
  String toString() {
    return 'VehicleRental{ '
        'id: $id, mark: $mark, seat: $seat, vehicleType: $vehicleType, '
        'description: $description, owner: $owner, imageUrl: $imageUrl, '
        'door: $door, address: $address, coordinates: $coordinates,}';
  }

  VehicleRental copyWith({
    Object? id,
    String? mark,
    int? seat,
    VehicleRentalType? vehicleType,
    String? description,
    dynamic? owner,
    List<dynamic>? imageUrl,
    int? door,
    AddressData? address,
    maps.LatLng? coordinates,
  }) {
    return VehicleRental(
      id: id ?? this.id,
      mark: mark ?? this.mark,
      seat: seat ?? this.seat,
      vehicleType: vehicleType ?? this.vehicleType,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      imageUrl: imageUrl ?? this.imageUrl,
      door: door ?? this.door,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
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
      'imageUrl': imageUrl,
      'door': door,
      'address': address,
      'coordinates': coordinates,
    };
  }

  factory VehicleRental.fromMap(Map<String, dynamic> map) {
    return VehicleRental(
      id: map['id'] as Object,
      mark: map['mark'] as String,
      seat: map['seat'] as int,
      vehicleType: map['vehicleType'] as VehicleRentalType,
      description: map['description'] as String,
      owner: map['owner'] as dynamic,
      imageUrl: map['imageUrl'] as List<dynamic>,
      door: map['door'] as int,
      address: map['address'] as AddressData,
      coordinates: map['coordinates'] as maps.LatLng,
    );
  }

//</editor-fold>
}