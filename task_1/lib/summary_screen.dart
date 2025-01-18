import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class SummaryScreen extends StatefulWidget {
  final int score;
  final int correctAnswers;
  final int wrongAnswers;

  const SummaryScreen({
    super.key,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();

    // Animation for trophy scaling
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
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
        child: Stack(
          children: [
            // Custom AppBar
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 16, 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left,
                          size: 40, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Content
            Column(
              children: [
                SizedBox(height: 240),
                Center(
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'assets/award.png',
                      height: 180,
                      width: 180,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  '🎉 Congratulations! 🎉',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 35),
                Text(
                  'Your Score: ${widget.score}',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Correct Answers: ${widget.correctAnswers}',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Wrong Answers: ${widget.wrongAnswers}',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      borderRadius: BorderRadius.circular(8), 
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), 
                          offset: const Offset(0, 2), 
                          blurRadius: 4, 
                        ),
                      ],
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, 
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Confetti Effect
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: [Colors.red, Colors.blue, Colors.green, Colors.yellow],
            ),
          ],
        ),
      ),
    );
  }
}
