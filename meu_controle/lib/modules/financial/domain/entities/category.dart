import 'package:flutter/material.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_entity.dart';

enum CategoryType { debit, credit }

class Category extends GenericEntity {
  Category(
      {required super.uuid,
      required super.tenant,
      required super.created,
      required super.createdBy,
      required super.updated,
      required super.updatedBy,
      required super.isActive,
      required this.parent,
      required this.code,
      required this.name,
      required this.color,
      required this.icon,
      required this.categoryType});
  String parent;
  String code;
  String name;
  Color color;
  Icon icon;
  CategoryType categoryType;

  Category.n(
      {this.parent = '',
      this.code = '',
      this.name = '',
      this.color = const Color.fromARGB(255, 66, 165, 245),
      this.icon = const Icon(Icons.circle),
      this.categoryType = CategoryType.debit})
      : super.n();

  @override
  List<Object?> get props => [uuid];
}
