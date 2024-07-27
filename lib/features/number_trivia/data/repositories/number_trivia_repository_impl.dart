import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/failure.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/network.dart';
import '../datasources/local/number_trivia_local_datasource.dart';
import '../datasources/remote/number_trivia_remote_datasource.dart';
import '../models/number_trivia_model.dart';
import '../../domain/entities/number_trivia_entity.dart';
import '../../domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDatasource numberTriviaLocalDatasource;
  final NumberTriviaRemoteDatasource numberTriviaRemoteDatasource;
  final Network network;

  NumberTriviaRepositoryImpl(
      {required this.numberTriviaLocalDatasource,
      required this.network,
      required this.numberTriviaRemoteDatasource});

  Future<Either<Failure, NumberTriviaEntity>> _getRandomTrivia(
      {required Future<NumberTriviaModel> Function() getTrivia}) async {
    if (await network.isConnected) {
      try {
        final results = await getTrivia();

        numberTriviaLocalDatasource.cacheNumberTrivia(results);
        return Right(results);
      } on ServerException {
        return const Left(ServerFailure(message: "Server Failure"));
      } 
    } else {
      try {
        final results = await numberTriviaLocalDatasource.getLastNumberTrivia();

        return Right(results);
      } on CacheException {
        return const Left(CacheFailure(message: "Cache Failure"));
      }
    }
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
      int number) async {
    return  _getRandomTrivia(
        getTrivia: () =>
            numberTriviaRemoteDatasource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomTrivia() async {
    return  _getRandomTrivia(
        getTrivia: numberTriviaRemoteDatasource.getRandomTrivia);
  }
}
