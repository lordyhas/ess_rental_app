part of data.model;

class SpaceRental extends AbstractModel{
  final Object id;
  final String label;
  final int room;
  final AddressData? address;
  final maps.LatLng? coordinates;
  final SpaceRentalType spaceType;

  RentalType get rentalType => RentalType.space;

//<editor-fold desc="Data Methods">

  const SpaceRental({
    required this.id,
    required this.label,
    required this.spaceType,

    this.coordinates,
    this.address,
    this.room = 1,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpaceRental &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label &&
          room == other.room &&
          address == other.address &&
          coordinates == other.coordinates &&
          spaceType == other.spaceType);

  @override
  int get hashCode =>
      id.hashCode ^
      label.hashCode ^
      room.hashCode ^
      address.hashCode ^
      coordinates.hashCode ^
      spaceType.hashCode;

  @override
  String toString() {
    return 'SpaceRental{ '
        'id: $id, label: $label, room: $room, '
        'address: $address, coordinates: $coordinates, '
        'spaceType: $spaceType,}';
  }

  SpaceRental copyWith({
    Object? id,
    String? label,
    int? room,
    AddressData? address,
    maps.LatLng? coordinates,
    SpaceRentalType? spaceType,
  }) {
    return SpaceRental(
      id: id ?? this.id,
      label: label ?? this.label,
      room: room ?? this.room,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      spaceType: spaceType ?? this.spaceType,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'label': this.label,
      'room': this.room,
      'address': this.address,
      'coordinates': this.coordinates,
      'spaceType': this.spaceType,
    };
  }

  factory SpaceRental.fromMap(Map<String, dynamic> map) {
    return SpaceRental(
      id: map['id'] as Object,
      label: map['label'] as String,
      room: map['room'] as int,
      address: map['address'] as AddressData,
      coordinates: map['coordinates'] as maps.LatLng,
      spaceType: map['spaceType'] as SpaceRentalType,
    );
  }

//</editor-fold>
}