import 'package:flutter/material.dart';
import 'package:task_1/quiz_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StartQuizScreen extends StatefulWidget {
  const StartQuizScreen({super.key});

  @override
  _StartQuizScreenState createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends State<StartQuizScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  List<dynamic> questions = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchQuizData() async {
    setState(() {
      isLoading = true;
    });

    try {
      const String url = 'https://api.jsonserve.com/Uw5CrX';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          questions = data['questions'];
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(questions: questions),
          ),
        );
      } else {
        throw Exception('Failed to load quiz data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  "Quiz App",
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/logo.png",
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 140,
            ),
            Center(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Loading quiz data...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : FadeTransition(
                      opacity: _fadeAnimation,
                      child: GestureDetector(
                        onTap: fetchQuizData,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Text(
                            'Start Quiz',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
