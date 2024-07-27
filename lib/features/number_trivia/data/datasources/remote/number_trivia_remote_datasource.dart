import 'dart:convert';
import 'package:http/http.dart';
import '../../../../../core/exceptions/exception.dart';
import '../../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomTrivia();
}

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource {
  final Client client;

  NumberTriviaRemoteDatasourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return await _getTriviaFromUrl("http://numbersapi.com/$number");
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    try {
      final response = await client.get(Uri.parse(url),  headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        return NumberTriviaModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
            message: response.reasonPhrase.toString(),
            code: response.statusCode.toString());
      }
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<NumberTriviaModel> getRandomTrivia() async {
    return await _getTriviaFromUrl("http://numbersapi.com/random");
  }
}
