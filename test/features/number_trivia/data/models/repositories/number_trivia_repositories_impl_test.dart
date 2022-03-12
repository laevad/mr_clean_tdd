import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mr_clean_tdd/core/platform/network_info.dart';
import 'package:mr_clean_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:mr_clean_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:mr_clean_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

import 'number_trivia_repositories_impl_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDataSource, NetworkInfo])
void main() {
  NumberTriviaRepositoryImpl repositoryImpl;
  MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource: mockNumberTriviaRemoteDataSource,
      localDataSource:mockNumberTriviaLocalDataSource,
      networkInfo:mockNetworkInfo,
    );
  });
}