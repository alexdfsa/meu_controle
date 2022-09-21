abstract class Mapper<T> {
  Map<String, dynamic> toMap(T model);
  T fromMap(Map<dynamic, dynamic> map);
}
