import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int? code;
  const Failure({required this.message, this.code});
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}
