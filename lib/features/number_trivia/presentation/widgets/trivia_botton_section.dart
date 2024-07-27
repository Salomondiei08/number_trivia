import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/number_trivia_bloc.dart';

class BottomSection extends StatefulWidget {
  const BottomSection({
    super.key,
  });

  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  TextEditingController controller = TextEditingController();

  String inputStr = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            inputStr = value.trim();
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          controller: controller,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.clear();

                  context.read<NumberTriviaBloc>().add(
                        GetConcreteNumberTrivia(
                          number: inputStr,
                        ),
                      );
                  inputStr = '';
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
                child: const Text('Search'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.grey),
                ),
                onPressed: () {
                  controller.clear();

                  context.read<NumberTriviaBloc>().add(
                        GetRandomNumberTrivia(),
                      );
                  inputStr = '';
                },
                child: const Text('Get random trivis'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
