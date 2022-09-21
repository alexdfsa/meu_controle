import 'package:meu_controle/modules/core/domain/entities/generic_entity.dart';

class Bank extends GenericEntity {
  Bank({
    required super.uuid,
    required super.tenant,
    required super.created,
    required super.createdBy,
    required super.updated,
    required super.updatedBy,
    required super.isActive,
    required this.code,
    required this.name,
  });
  String code;
  String name;

  Bank.n({this.code = '', this.name = ''}) : super.n();

  @override
  List<Object?> get props => [uuid];
}
