part of data.model;

class RentalSpace extends RentalProduct {
  final String label;
  final dynamic id;
  final String description;
  final RentalSpaceType spaceType;

  final dynamic owner;
  final int room;
  final List<dynamic> images;
  final AddressData? address;
  final maps.LatLng? coordinates;
  final bool isTaken;
  final int? price;
  final PricePer pricePer;

  const RentalSpace({
    required this.id, // auto
    required this.label,
    required this.description,
    required this.spaceType,
    required this.price,
    this.owner, // auto
    this.room = 1,
    this.images = const [],
    this.address,
    this.coordinates,
    this.isTaken = false, // auto
    this.pricePer = PricePer.day, // auto
  });



  static const empty = RentalSpace(
      id: '',
      label: '',
      description: '',
      price: null,
      spaceType: RentalSpaceType.unknown
  );


  /// Convenience getter to determine whether the current [RentalSpace] is empty.
  bool get isEmpty => this == RentalSpace.empty;

  /// Convenience getter to determine whether the current [RentalSpace] is not empty.
  bool get isNotEmpty => this != RentalSpace.empty;

  bool get isComplete => isNotEmpty && images.isNotEmpty;

  @override
  RentalType get rentalType => RentalType.space;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is RentalSpace &&
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
              isTaken == other.isTaken &&
              price == other.price &&
              pricePer == other.pricePer
          );

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
    return 'SpaceRental{ id: $id, label: $label, room: $room, pricePer: $pricePer,'
        'price: $price, spaceType: $spaceType, description: $description, '
        'owner: $owner, images: $images, address: $address, '
        'coordinates: $coordinates, isTaken: $isTaken,}';
  }

  @override
  RentalSpace copyWith({
    id,
    String? label,
    int? room,
    int? price,
    RentalSpaceType? spaceType,
    String? description,
    owner,
    List<dynamic>? images,
    AddressData? address,
    maps.LatLng? coordinates,
    bool? isTaken,
    PricePer? pricePer
  }) {
    return RentalSpace(
      id: id ?? this.id,
      label: label ?? this.label,
      room: room ?? this.room,
      price: price ?? this.price,
      spaceType: spaceType ?? this.spaceType,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      images: images ?? this.images,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      isTaken: isTaken ?? this.isTaken,
      pricePer: pricePer ?? this.pricePer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'room': room,
      'price': price,
      'spaceType': spaceType.index,
      'description': description,
      'owner': owner,
      'images': images,
      'address': address?.toMap(),
      'coordinates': coordinates?.toJson(),
      'isTaken': isTaken,
      'pricePer': pricePer.index,
    };
  }

  factory RentalSpace.fromMap(Map<String, dynamic> map) {
    return RentalSpace(
      id: map['id'],
      label: map['label'] as String,
      room: map['room'] as int,
      price: map['price'] as int,
      spaceType: RentalSpaceType.values[map['spaceType']],
      description: map['description'] as String,
      owner: map['owner'] as dynamic,
      images: map['images'] as List<dynamic>,
      address: AddressData.fromMap(map['address']),
      coordinates: maps.LatLng.fromJson(map['coordinates']),
      pricePer: PricePer.values[map['pricePer']],
      isTaken: map['isTaken'] as bool,
    );
  }


}
