part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetRandomNumberTrivia extends NumberTriviaEvent {}

class GetConcreteNumberTrivia extends NumberTriviaEvent {
  final String number;

  const GetConcreteNumberTrivia({required this.number});
}
