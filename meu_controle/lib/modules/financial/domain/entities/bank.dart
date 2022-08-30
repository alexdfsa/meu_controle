import 'package:equatable/equatable.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_entity.dart';

class Bank extends Equatable with GenericEntity {
  const Bank({
    this.uuid = '',
    this.code = '',
    this.name = '',
  });
  final String uuid;
  final String code;
  final String name;

  @override
  List<Object?> get props => [uuid, code, name];
}
