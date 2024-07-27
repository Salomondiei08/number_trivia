part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class Initial extends NumberTriviaState {}

class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message});
}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTriviaEntity numberTriviaEntity;
  const Loaded({required this.numberTriviaEntity});
}
