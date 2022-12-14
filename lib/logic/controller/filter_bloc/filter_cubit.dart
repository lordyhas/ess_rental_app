import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import 'package:exploress_rental/logic/values.dart';





part 'filter_data.dart';
part 'filter_state.dart';

class FilterCubit extends Cubit<Filter> {
  FilterCubit(Filter filter) : super(filter);

  void change({
    double? maxPrice,
    double? minPrice,
    double? maxDistance,
    double? minDistance,
    List<Category> categories = const<Category>[],
  }){
    emit(state.copyWith(
      maxPrice: maxPrice,
      minPrice: minPrice,
      maxDistance: maxDistance,
      minDistance: minDistance,
      category: categories,
    ));
  }


}
