import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/firebase/firebase_datasource.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/mappers/bank_mapper.dart';
import 'package:meu_controle/modules/financial/infra/interfaces/datasources/i_datasource.dart';

class BankFirestoreDatasource extends FirebaseDatasource<Bank>
    with BankMapper
    implements IDatasource {
  BankFirestoreDatasource() : super('bank');
}
