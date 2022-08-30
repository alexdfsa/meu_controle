import 'package:json_annotation/json_annotation.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank_entity.dart';

//part 'bank.g.dart';

@JsonSerializable(explicitToJson: true)
class Bank extends BankEntity {
  Bank({
    final String code = '',
    final String name = '',
  }) : super(code: code, name: name);

  //factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  //Map<String, dynamic> toJson() => _$BankToJson(this);
}
