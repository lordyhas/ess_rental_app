
import 'package:hive/hive.dart';

abstract class XDatabaseManager{}


abstract class XHiveBoxManager{
  void onInit<E extends HiveObject>(TypeAdapter<E> typeAdapter);
  void onUpdate();
  Future<bool> addField(Object object);
  Future<bool> deleteField(Object object);
  Future<bool> updateField(Object object);
  Future<Object> getField(Object object);
  Future<List<Object>>  getAllData(Object object);
}

mixin HiveManager{

  Future<bool> addObject<T>(Map map,  [String? key]) async {

    return true;
  }

}
