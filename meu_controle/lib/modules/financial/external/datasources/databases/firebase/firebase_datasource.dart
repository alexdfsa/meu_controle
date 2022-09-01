import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_entity.dart';

abstract class FirebaseDatasource<T extends GenericEntity> extends Mapper<T> {
  late CollectionReference collection;
  FirebaseDatasource(String col) {
    collection = FirebaseFirestore.instance.collection(col);
  }

  Future<bool> saveOrUpdate(model) async {
    collection.doc(model.uuid).set(toMap(model));
    return true;
  }

  Future<T> get(String uuid) async {
    var result = await collection.doc(uuid).get();
    return fromMap(result.data() as Map);
  }

  Future<List<T>> getAll() async {
    List<T> resultList = [];
    try {
      var result = await collection.get();
      resultList = result.docs.map((e) => fromMap(e.data() as Map)).toList();
    } on Exception catch (ex, stack) {
      DatasourceException(
          stack, 'firebase_datasource-getAll', ex, ex.toString());
    } catch (e, stack) {
      UnknownError(e, stack, 'firebase_datasource-getAll');
    }
    return resultList;
  }

  Future<bool> delete(String uuid) async {
    await collection.doc(uuid).delete();
    return true;
  }

  Future<Stream<List<T>>> getStreamList() async {
    var result = collection.snapshots();
    return result.map(
        (events) => events.docs.map((e) => fromMap(e.data() as Map)).toList());
  }
}

abstract class Mapper<T> {
  Map<String, dynamic> toMap(T model);
  T fromMap(Map<dynamic, dynamic> map);
}
