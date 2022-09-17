import 'package:flutter/material.dart';

enum ExceptionType {
  //Domain Exceptions
  entityException,
  useCaseException,

  //Infra Exceptions
  repositoryException,

  //External Exceptions
  datasourceException,
  driverException,

  //Presenter Exceptions
  pageException,
  stateException,
  storeException,
  widgetException,

  //Unknown Exception
  unknownException
}

abstract class Failure implements Exception {
  final String errorMessage;
  final ExceptionType exceptionType;

  Failure(
      {StackTrace? stackTrace,
      String? label,
      dynamic exception,
      required this.errorMessage,
      required this.exceptionType}) {
    if (stackTrace != null) {
      debugPrintStack(label: label, stackTrace: stackTrace);
    }
    //TODO: Implementar crashanalitics
    //ErrorReport.
  }
}

class UnknownError extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  UnknownError(this.exception, this.stackTrace, this.label)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.unknownException,
            exception: exception,
            errorMessage: 'Unknown Error');
}
/*
class errorReport {
  static Future<void> _report{
    dynamic exception,
    StackTrace stackTrace,
    String tag,
  } async {
    if (!(Platform))
  }
}

static void externalFailureError(dynamic exception, StackTrace stackTrace, String? reportTag){
if(stackTrace !=null && reportTag !=null){
  _report(exception, stackTrace, 'EXTERNAL_FAILURE: $reportTag');
}
}

_report(){}
*/

class EntityException extends Failure {
  EntityException(StackTrace stackTrace, String label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exception: exception,
            exceptionType: ExceptionType.entityException,
            errorMessage: errorMessage);
}

class UseCaseException extends Failure {
  UseCaseException(StackTrace stackTrace, String label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.useCaseException,
            exception: exception,
            errorMessage: errorMessage);
}

class RepositoryException extends Failure {
  RepositoryException(StackTrace stackTrace, String label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.repositoryException,
            exception: exception,
            errorMessage: errorMessage);
}

class DatasourceException extends Failure {
  DatasourceException(StackTrace? stackTrace, String? label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.datasourceException,
            exception: exception,
            errorMessage: errorMessage);
}

class DriverException extends Failure {
  DriverException(StackTrace? stackTrace, String? label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.driverException,
            exception: exception,
            errorMessage: errorMessage);
}

class PageException extends Failure {
  PageException(StackTrace stackTrace, String label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.pageException,
            exception: exception,
            errorMessage: errorMessage);
}

class StateException extends Failure {
  StateException(StackTrace stackTrace, String label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.stateException,
            exception: exception,
            errorMessage: errorMessage);
}

class StoreException extends Failure {
  StoreException(StackTrace stackTrace, String label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.storeException,
            exception: exception,
            errorMessage: errorMessage);
}

class WidgetException extends Failure {
  WidgetException(StackTrace stackTrace, String label, dynamic exception,
      String errorMessage)
      : super(
            stackTrace: stackTrace,
            label: label,
            exceptionType: ExceptionType.widgetException,
            exception: exception,
            errorMessage: errorMessage);
}
