import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exceptions/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_create_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - Number must be an integer and above 0 ';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String UNEXPECTED_ERROR = 'Unexpected Error';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(NumberTriviaInitial()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final inputEither =
          inputConverter.stringToUnsignedInt(event.numberString);

      await Future.sync(
        () => inputEither.fold(
          (failure) => emit(const NumberTriviaFailure(
              errorMessage: INVALID_INPUT_FAILURE_MESSAGE)),
          (integer) async {
            emit(NumberTriviaLoading());

            final failureOrTrivia =
                await getConcreteNumberTrivia(Params(number: integer));
            _eitherLoadedOrErrorState(emit, failureOrTrivia);
          },
        ),
      );
    });

    on<GetTriviaForRandomNumber>(
      (event, emit) async {
        emit(NumberTriviaLoading());
        final failureOrTrivia = await getRandomNumberTrivia(NoParams());
        _eitherLoadedOrErrorState(emit, failureOrTrivia);
      },
    );
  }

  void _eitherLoadedOrErrorState(Emitter<NumberTriviaState> emit,
          Either<Failure, NumberTrivia> failureOrTrivia) =>
      failureOrTrivia.fold(
        (failure) => emit(
          NumberTriviaFailure(
            errorMessage: _mapFailureToMessage(failure),
          ),
        ),
        (trivia) => emit(NumberTriviaLoaded(trivia: trivia)),
      );

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_ERROR;
    }
  }
}
