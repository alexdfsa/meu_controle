import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_entity.dart';

class FinantialEntry extends GenericEntity {
  FinantialEntry(
      {required super.uuid,
      required super.tenant,
      required super.created,
      required super.createdBy,
      required super.updated,
      required super.updatedBy,
      required super.isActive,
      required this.date,
      required this.amount,
      required this.isFixed,
      required this.hasInstallment,
      required this.qtyInstallment,
      required this.isRealized,
      required this.description,
      required this.category,
      required this.account,
      required this.comments});
  Timestamp date; // Data/Hora do lançamento financeiro
  double amount; // Total do lançamento
  bool isRealized; // Se lançamento foi totalmente quitado
  bool
      hasInstallment; // Se possui parcelas. Caso tenha parcelas, o isRealized deverá ser alterado para false e oculto
  int qtyInstallment; // Quantidade de parcelas, para realizar o cálculo sugestivo das parcelas
  bool isFixed; // Lançamento fixo. Deverá habilitar o botão para gerar quitação
  String description;
  String category;
  String account;
  String comments;

  FinantialEntry.n(
      {this.amount = 0,
      this.isFixed = false,
      this.hasInstallment = false,
      this.qtyInstallment = 1,
      this.isRealized = true,
      this.description = '',
      this.category = '',
      this.account = '',
      this.comments = ''})
      : date = Timestamp.fromDate(DateTime.now()),
        super.n();

  @override
  List<Object?> get props => [uuid];
}
