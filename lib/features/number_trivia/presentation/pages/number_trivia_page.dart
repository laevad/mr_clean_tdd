import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widget/loading_widget.dart';
import '../widget/message_display.dart';
import '../widget/trivia_controls.dart';
import '../widget/trivia_display.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is NumberTriviaInitial) {
                    return const MessageDisplay(message: 'Start Searching!');
                  } else if (state is NumberTriviaLoading) {
                    return const LoadingWidget();
                  } else if (state is NumberTriviaLoaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is NumberTriviaFailure) {
                    return MessageDisplay(message: state.errorMessage);
                  } else {
                    return const Text('Unexpected Error!');
                  }
                },
              ),
              const TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}