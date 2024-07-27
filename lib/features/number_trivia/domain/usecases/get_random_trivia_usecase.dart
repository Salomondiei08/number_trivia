import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecase.dart';
import '../entities/number_trivia_entity.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomTriviaUseCase implements UseCase<NumberTriviaEntity, NoParams> {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomTriviaUseCase(this.numberTriviaRepository);
  @override
  Future<Either<Failure, NumberTriviaEntity>> call(NoParams params) {
    return numberTriviaRepository.getRandomTrivia();
  }
}
