import 'package:flutter/material.dart';
import 'package:task_1/quiz_screen.dart';
import 'package:task_1/start_quiz_screen.dart';


void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartQuizScreen(),
      routes: {'/quiz': (context) => QuizScreen(questions: [])},
    );
  }
}

