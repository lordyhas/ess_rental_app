part of data.model;

class SpaceRental extends StuffRental {
  final Object id;
  final String label;
  final int room;
  final SpaceRentalType spaceType;
  final String description;
  final dynamic owner;
  final List<dynamic> images;
  final AddressData? address;
  final maps.LatLng? coordinates;

  @override
  RentalType get rentalType => RentalType.space;
  List<String> get imageUrl => images as List<String>;


  static SpaceRental empty = SpaceRental(
      id: '',
      label: '',
      spaceType: SpaceRentalType.apartment,
      description: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == SpaceRental.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != SpaceRental.empty;

//<editor-fold desc="Data Methods">

  const SpaceRental({
    required this.id,
    required this.label,
    required this.spaceType,
    required this.description,
    this.images = const [],
    this.room = 1,
    this.owner,
    this.address,
    this.coordinates,
  }) : assert(room < 1, "a space for rent can't have less than 1 room");
        //assert(imageUrl[0] == null, "an rental space can't have less than 1 room");

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
          spaceType == other.spaceType &&
          description == other.description &&
          owner == other.owner &&
          images == other.images);

  @override
  int get hashCode =>
      id.hashCode ^
      label.hashCode ^
      room.hashCode ^
      address.hashCode ^
      coordinates.hashCode ^
      spaceType.hashCode ^
      description.hashCode ^
      owner.hashCode ^
      images.hashCode;

  @override
  String toString() {
    return 'SpaceRental{ '
        'id: $id, '
        'label: $label, '
        'room: $room, '
        'address: $address, '
        'coordinates: $coordinates, '
        'spaceType: $spaceType, '
        'description: $description, '
        'owner: $owner, '
        'imageUrl: $images,'
        '}';
  }

  SpaceRental copyWith({
    Object? id,
    String? label,
    int? room,
    AddressData? address,
    maps.LatLng? coordinates,
    SpaceRentalType? spaceType,
    String? description,
    dynamic owner,
    List<dynamic>? images,
  }) {
    return SpaceRental(
      id: id ?? this.id,
      label: label ?? this.label,
      room: room ?? this.room,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      spaceType: spaceType ?? this.spaceType,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'room': room,
      'address': address,
      'coordinates': coordinates,
      'spaceType': spaceType,
      'description': description,
      'owner': owner,
      'imageUrl': images,
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
      description: map['description'] as String,
      owner: map['owner'] as dynamic,
      images: map['imageUrl'] as List<dynamic>,
    );
  }

//</editor-fold>
}
