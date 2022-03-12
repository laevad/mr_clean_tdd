import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia(int number);

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}
