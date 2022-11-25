part of data.model;

class SpaceRental extends StuffRental {
  final String label;
  final dynamic id;
  final String description;
  final SpaceRentalType spaceType;

  final dynamic owner;
  final int room;
  final List<dynamic> images;
  final AddressData? address;
  final maps.LatLng? coordinates;
  final bool isTaken;

  const SpaceRental({
    required this.label,
    required this.id,
    required this.description,
    required this.spaceType,
    this.owner,
    this.room = 1,
    this.images = const [],
    this.address,
    this.coordinates,
    this.isTaken = false,
  });


  static const empty = SpaceRental(
      label: '',
      id: '',
      description: '',
      spaceType: SpaceRentalType.apartment
  );


  /// Convenience getter to determine whether the current [SpaceRental] is empty.
  bool get isEmpty => this == SpaceRental.empty;

  /// Convenience getter to determine whether the current [SpaceRental] is not empty.
  bool get isNotEmpty => this != SpaceRental.empty;

  @override
  RentalType get rentalType => RentalType.space;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is SpaceRental &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              label == other.label &&
              room == other.room &&
              spaceType == other.spaceType &&
              description == other.description &&
              owner == other.owner &&
              images == other.images &&
              address == other.address &&
              coordinates == other.coordinates &&
              isTaken == other.isTaken);

  @override
  int get hashCode =>
      id.hashCode ^
      label.hashCode ^
      room.hashCode ^
      spaceType.hashCode ^
      description.hashCode ^
      owner.hashCode ^
      images.hashCode ^
      address.hashCode ^
      coordinates.hashCode ^
      isTaken.hashCode;

  @override
  String toString() {
    return 'SpaceRental{ id: $id, label: $label, room: $room, '
        'spaceType: $spaceType, description: $description, '
        'owner: $owner, images: $images, address: $address, '
        'coordinates: $coordinates, isTaken: $isTaken,}';
  }

  SpaceRental copyWith({
    id,
    String? label,
    int? room,
    SpaceRentalType? spaceType,
    String? description,
    owner,
    List<dynamic>? images,
    AddressData? address,
    maps.LatLng? coordinates,
    bool? isTaken,
  }) {
    return SpaceRental(
      id: id ?? this.id,
      label: label ?? this.label,
      room: room ?? this.room,
      spaceType: spaceType ?? this.spaceType,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      images: images ?? this.images,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      isTaken: isTaken ?? this.isTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'room': room,
      'spaceType': spaceType,
      'description': description,
      'owner': owner,
      'images': images,
      'address': address,
      'coordinates': coordinates,
      'isTaken': isTaken,
    };
  }

  factory SpaceRental.fromMap(Map<String, dynamic> map) {
    return SpaceRental(
      id: map['id'],
      label: map['label'] as String,
      room: map['room'] as int,
      spaceType: map['spaceType'] as SpaceRentalType,
      description: map['description'] as String,
      owner: map['owner'] as dynamic,
      images: map['images'] as List<dynamic>,
      address: map['address'] as AddressData,
      coordinates: map['coordinates'] as maps.LatLng,
      isTaken: map['isTaken'] as bool,
    );
  }


}
