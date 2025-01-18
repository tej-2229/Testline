import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_1/summary_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<dynamic> questions;

  const QuizScreen({super.key, required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int streak = 0;
  double progress = 0;
  int? selectedOptionIndex; 
  bool isAnswered = false; 

  void handleAnswer(bool isCorrect, int index) {
    setState(() {
      selectedOptionIndex = index;
      isAnswered = true;

      if (isCorrect) {
        score += 1;
        correctAnswers += 1;
        streak += 1;
      } else {
        wrongAnswers += 1; 
        streak = 0; 
      }

      // Delay for showing correct and wrong answers before moving to the next question
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          if (currentQuestionIndex < widget.questions.length - 1) {
            currentQuestionIndex++;
            progress = (currentQuestionIndex + 1) / widget.questions.length;
            selectedOptionIndex = null;
            isAnswered = false;
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SummaryScreen(
                  score: score,
                  correctAnswers: correctAnswers,
                  wrongAnswers: wrongAnswers,
                ),
              ),
            );
          }
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];
    final options = question['options'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left,
                          size: 40, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 70),
                    const Center(
                      child: Text(
                        "Questions",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '10/${currentQuestionIndex + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 6.0,
                      percent: progress,
                      center: Text(
                        '${((progress) * 100).toInt()}%',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      progressColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.3),
                    ),
                    Text(
                      'Score: $score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Question Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              question['description'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Options Section
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                Color optionColor = Colors.white;

                // Highlight correct and wrong answers
                if (isAnswered) {
                  if (option['is_correct']) {
                    optionColor = Colors.green; 
                  } else if (selectedOptionIndex == index) {
                    optionColor = Colors.red; 
                  }
                }

                return GestureDetector(
                  onTap: isAnswered
                      ? null
                      : () => handleAnswer(option['is_correct'], index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: optionColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      option['description'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
