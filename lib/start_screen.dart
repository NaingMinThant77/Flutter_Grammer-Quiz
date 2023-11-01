import 'package:flutter/material.dart';
import 'package:answers/quiz.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Grammar Quiz App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          color: const Color.fromARGB(255, 174, 222, 245),
          child: Container(
           alignment: Alignment.center,
            child: Card(
              color: Colors.lightBlue,
              elevation: 5, // Add some elevation for a shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 200), 
                      const Icon(
                        Icons.question_answer, 
                        color: Colors.white,
                        size: 100,
                      ),
                      const SizedBox(height: 10), 
                      const Text(
                        'Grammar Quiz App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 30),
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Quiz(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text('Start Quiz' , 
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
