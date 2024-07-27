import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'core/network.dart';
import 'features/number_trivia/data/datasources/local/number_trivia_local_datasource.dart';
import 'features/number_trivia/data/datasources/remote/number_trivia_remote_datasource.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_trivia_number.dart';
import 'features/number_trivia/domain/usecases/get_random_trivia_usecase.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Blocs - number trivia
  sl.registerFactory(() => NumberTriviaBloc(
      getRandomTriviaUseCase: sl(), getConcreteTriviaUseCase: sl()));

//! UseCases - number trivia
  sl.registerLazySingleton(() => GetRandomTriviaUseCase(sl()));
  sl.registerLazySingleton(() => GetConcreteTriviaUseCase(sl()));

//! Repository - number trivia
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            numberTriviaLocalDatasource: sl(),
            numberTriviaRemoteDatasource: sl(),
            network: sl(),
          ));

//! Data Sources - number trivia
  sl.registerLazySingleton<NumberTriviaLocalDatasource>(
      () => NumberTriviaLocalDatasourceImpl(prefs: sl()));

  sl.registerLazySingleton<NumberTriviaRemoteDatasource>(
      () => NumberTriviaRemoteDatasourceImpl(client: sl()));

//! Core
  sl.registerLazySingleton<Network>(() => NetworkImpl());

  //! External
  sl.registerLazySingleton(() => Client());

  final sharedPreferenceInstance = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferenceInstance);
}
