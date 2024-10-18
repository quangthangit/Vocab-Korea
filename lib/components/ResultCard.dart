import 'package:flutter/material.dart';
import 'package:vocabkpop/models/ResultModel.dart';

class ResultCard extends StatelessWidget {
  final ResultModel result;

  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(result.question),
              ),
              const SizedBox(height: 10),
              const Divider(color: Colors.blueGrey),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(result.answer),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  result.answerUser == result.answer ? const Icon(Icons.check, color: Colors.green) : const Icon(Icons.close, color: Colors.red),
                  const SizedBox(height: 20),
                  result.answerUser == result.answer ? Text(result.answerUser,
                      style: const TextStyle(color: Colors.green)) : Text(result.answerUser,
                      style: const TextStyle(color: Colors.red)),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          color: result.answer == result.answerUser ? Colors.green : Colors.red,
          child: Row(
            children: [
              result.answerUser == result.answer ? const Icon(Icons.check, color: Colors.white) : const Icon(Icons.close, color: Colors.white),
              const SizedBox(width: 20),
              Text(result.answer, style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}