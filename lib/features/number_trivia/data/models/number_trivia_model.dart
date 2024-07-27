import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/number_trivia_entity.dart';
part  'number_trivia_model.g.dart';


@JsonSerializable()
class NumberTriviaModel extends NumberTriviaEntity {
  final String text;
  final int number;

 const NumberTriviaModel({required this.text, required this.number}) : super(text: text, number: number);


  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);


  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this); 
}
