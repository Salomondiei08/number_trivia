import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

import '../bloc/number_trivia_bloc.dart';
import '../widgets/widget.dart';

class NumberTriviaScreen extends StatefulWidget {
  const NumberTriviaScreen({super.key});

  @override
  State<NumberTriviaScreen> createState() => _NumberTriviaScreenState();
}

class _NumberTriviaScreenState extends State<NumberTriviaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Trivia App'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocProvider(
        create: (context) => sl<NumberTriviaBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildTextSection(),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: BottomSection(),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is Loading) {
          return const TriviaBodyWidget(
            child: CircularProgressIndicator(),
          );
        } else if (state is Initial) {
          return const TriviaBodyWidget(
            child: Text(
              'Start Trivia',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          );
        } else if (state is Loaded) {
          final trivia = state.numberTriviaEntity;
          return TriviaBodyWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  trivia.number.toString(),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Text(
                    trivia.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        } else if (state is Error) {
          final message = state.message;

          return TriviaBodyWidget(
            child: Text(
              message,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Unexcepted Error',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      },
    );
  }
}
