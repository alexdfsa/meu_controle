import 'package:equatable/equatable.dart';
import 'package:meu_controle/core/domain/entities/entity.dart';

abstract class BankEntity extends Equatable with Entity {
  BankEntity({
    this.code = '',
    this.name = '',
  });

  final String code;
  final String name;

  @override
  List<Object?> get props => [uuid, code, name];
}
