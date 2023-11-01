import 'package:flutter/material.dart';
import 'package:answers/quiz.dart';
import 'package:answers/start_screen.dart';

class ResultScreen extends StatelessWidget {
  final int totalScore;
  final int maxScore;

  ResultScreen({
    required this.totalScore,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Container(
        color: Colors.lightBlue, // Set the background color of the body
        child: Center(
          child: Container(
            height: 350,
            width: 300,
            child: Card(
              color: Colors.white, // Set the card background color to white
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.emoji_events, 
                        color: Colors.lightBlue, 
                        size: 100,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        totalScore > 4
                            ? 'Congratulations! Your final score is: $totalScore/$maxScore'
                            : 'Your final score is: $totalScore/$maxScore. Better luck next time!',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: totalScore > 4 ? Colors.green : Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Quiz(),
                            ),
                          );
                        },
                        child: Text('Restart Quiz'),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StartScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text('Exit Quiz'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
