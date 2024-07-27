import 'dart:convert';
import '../../../../../core/exceptions/exception.dart';
import '../../models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaEntity);
}

const key = "CACHED_NUMBER_TRIVIA";

class NumberTriviaLocalDatasourceImpl implements NumberTriviaLocalDatasource {
  // Obtain shared preferences.
  final SharedPreferences prefs;

  NumberTriviaLocalDatasourceImpl({required this.prefs});
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaEntity) {
    prefs.setString(key, jsonEncode(triviaEntity.toJson()));
    return Future.value();
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final trivia = prefs.getString(key);

    if (trivia != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(trivia)));
    } else {
      throw CacheException(message: 'No number trivia found', code: '404');
    }
  }
}
