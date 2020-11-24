import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => const <dynamic>[];
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => const <dynamic>[];
}
