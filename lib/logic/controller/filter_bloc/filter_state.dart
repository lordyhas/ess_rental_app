part of 'filter_cubit.dart';


class Filter extends Equatable {
  final double maxPrice;
  final double minPrice;
  final double maxDistance;
  final double minDistance;
  final List<Category> category;
  const Filter._({
      this.maxPrice = maximumPrice,
      this.minPrice = 0.0,
      this.maxDistance = 0.0,
      this.minDistance = 0.0,
      this.category = const[],
  });

  Filter.unknown() : this._();
  Filter.values({
    required double maxPrice,
    required double minPrice,
    required double maxDistance,
    required double minDistance,
    required List<Category> categoryList,
  }) : this._(
      maxPrice: maxPrice,
      minPrice: minPrice,
      maxDistance: maxDistance,
      minDistance: minDistance,
      category: categoryList,
  );

  Filter copyWith({
    double? maxPrice,
    double? minPrice,
    double? maxDistance,
    double? minDistance,
    List<Category> category = const[],
  }) => Filter.values(
      maxPrice: maxPrice ?? this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
      maxDistance: maxDistance ?? this.maxDistance,
      minDistance: minDistance ?? this.minDistance,
      categoryList: category,
  );


  @override
  List<Object> get props => [
    maxPrice, minPrice, maxDistance, minDistance, category
  ];
}





