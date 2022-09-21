import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_entity.dart';

class Installment extends GenericEntity {
  Installment({
    required super.uuid,
    required super.tenant,
    required super.created,
    required super.createdBy,
    required super.updated,
    required super.updatedBy,
    required super.isActive,
    required this.date,
    required this.sequence,
    required this.amount,
    required this.isRealized,
  });

  Timestamp date;
  int sequence;
  double amount;
  bool isRealized;

  Installment.n({
    this.sequence = 0,
    this.amount = 0,
    this.isRealized = false,
  })  : date = Timestamp.fromDate(DateTime.now()),
        super.n();

  @override
  List<Object?> get props => [uuid];
}
