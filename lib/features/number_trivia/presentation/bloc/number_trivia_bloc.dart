import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase.dart';
import '../../domain/entities/number_trivia_entity.dart';
import '../../domain/usecases/get_concrete_trivia_number.dart';
import '../../domain/usecases/get_random_trivia_usecase.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomTriviaUseCase getRandomTriviaUseCase;
  final GetConcreteTriviaUseCase getConcreteTriviaUseCase;

  NumberTriviaBloc(
      {required this.getRandomTriviaUseCase,
      required this.getConcreteTriviaUseCase})
      : super(Initial()) {
    on<GetRandomNumberTrivia>(_onGetRandomNumberTrivia);
    on<GetConcreteNumberTrivia>(_onGetConcreteNumberTrivia);
  }

  Future<void> _onGetRandomNumberTrivia(
      GetRandomNumberTrivia event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());

    final result = await getRandomTriviaUseCase(NoParams());

    result.fold((e) => emit(Error(message: e.message)),
        (trivia) => emit(Loaded(numberTriviaEntity: trivia)));
  }

  Future<void> _onGetConcreteNumberTrivia(
      GetConcreteNumberTrivia event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());

    final number = int.tryParse(event.number);
    if (number == null) {
      return emit(const Error(message: 'Invalid number'));
    }

    final result = await getConcreteTriviaUseCase(Params(number: number));

    result.fold((e) => emit(Error(message: e.message)),
        (trivia) => emit(Loaded(numberTriviaEntity: trivia)));
  }
}
