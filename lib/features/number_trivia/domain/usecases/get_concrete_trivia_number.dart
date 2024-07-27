import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecase.dart';
import '../entities/number_trivia_entity.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteTriviaUseCase implements UseCase<NumberTriviaEntity, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteTriviaUseCase(this.numberTriviaRepository);
  @override
  Future<Either<Failure, NumberTriviaEntity>> call(Params params) {
    return numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;
  const Params({required this.number});

  @override
  List<Object> get props => [number];
}
