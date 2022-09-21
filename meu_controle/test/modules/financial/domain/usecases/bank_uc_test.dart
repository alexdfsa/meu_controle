import 'package:flutter_test/flutter_test.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/domain/interfaces/repositories/i_bank_repository.dart';
import 'package:meu_controle/modules/financial/domain/usecases/bank_uc.dart';
import 'package:mocktail/mocktail.dart';

class BankUCTest extends Mock implements IBankRepository {}

void main() {
  late BankUCTest bankUCTest;

  late BankUC bankUsecase;

  setUp(() {
    bankUCTest = BankUCTest();
    bankUsecase = BankUC();
  });

  test(
      'Deve retornar List<Bank> quando a chamada para o getAll do repositório for sucedida',
      () async {
    //Arrange
    final response = <Bank>[
      Bank.n(),
    ];

    when(() => bankUCTest.getAll()).thenAnswer(
      (_) async => response,
    );

    //Act
    final result = await bankUsecase.getAll();

    //Assert
    expect(result, response);
  });
}
