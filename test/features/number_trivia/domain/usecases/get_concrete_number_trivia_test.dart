import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mr_clean_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mr_clean_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mr_clean_tdd/features/number_trivia/domain/usecases/get_create_number_trivia.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetConcreteNumberTrivia useCase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });
  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: 1, text: "test text");
  test('should get trivia number from the repository', () async {
    // arrange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => const Right(tNumberTrivia));
    // act
    final result = await useCase.execute(number: tNumber);
    // assert
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
