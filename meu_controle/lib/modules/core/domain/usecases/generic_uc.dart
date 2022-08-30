import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/modules/core/domain/interfaces/repositories/generic_repository.dart';

abstract class GenericUC<T extends Object> implements GenericRepository {
  final dynamic repository = Modular.get<T>();

  @override
  Future<bool> delete(uuid) {
    return repository.delete(uuid: uuid);
  }

  @override
  Future get(String uuid) {
    return repository.get(uuid: uuid);
  }

  @override
  Future<List> getAll() {
    return repository.getAll();
  }

  @override
  Future<bool> saveOrUpdate(model) {
    return repository.saveOrUpdate(model: model);
  }

  @override
  Future<Stream<List>> getStreamList() {
    return repository.getStreamList();
  }
}
