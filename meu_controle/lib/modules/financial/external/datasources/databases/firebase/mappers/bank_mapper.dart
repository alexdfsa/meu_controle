import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/firebase/firebase_datasource.dart';

mixin BankMapper implements Mapper<Bank> {
  @override
  Map<String, dynamic> toMap(Bank bank) {
    return {'uuid': bank.uuid, 'code': bank.code, 'name': bank.name};
  }

  @override
  Bank fromMap(Map<dynamic, dynamic> map) {
    return Bank(
      uuid: map['uuid'],
      code: map['code'],
      name: map['name'],
    );
  }
}
