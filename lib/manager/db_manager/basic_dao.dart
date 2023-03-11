/// pinpin - basic_dao
/// Created by xhz on 3/11/23

import 'package:floor/floor.dart';

abstract class BasicDao<T> {
  //return primary key
  @insert
  Future<int> add(T item);

  @insert
  Future<List<int>> addList(List<T> list);

  @update
  Future<int> updateItem(T item);
}
