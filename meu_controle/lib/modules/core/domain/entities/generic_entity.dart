import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meu_controle/modules/app/utils/app.dart';

abstract class GenericEntity extends Equatable {
  String uuid;
  final String tenant;
  final Timestamp created;
  final String createdBy;
  Timestamp updated;
  String updatedBy;
  bool isActive;

  GenericEntity({
    required this.uuid,
    required this.tenant,
    required this.created,
    required this.createdBy,
    required this.updated,
    required this.updatedBy,
    required this.isActive,
  });

  GenericEntity.n()
      : uuid = '',
        tenant = App.currentTenant(),
        createdBy = App.currentUser(),
        created = Timestamp.fromDate(DateTime.now()),
        updatedBy = App.currentUser(),
        updated = Timestamp.fromDate(DateTime.now()),
        isActive = true;
}
