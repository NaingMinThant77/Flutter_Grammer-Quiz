import 'package:flutter/material.dart';
import 'answer.dart';
import 'result_screen.dart';
import 'package:answers/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  String activeScreen = 'questions-screen';
  List<Map<String, Object>> selectedAnswers = [];

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if the answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 25,
              )
            : const Icon(
                Icons.clear,
                color: Colors.red,
                size: 25,
              ),
      );

      selectedAnswers.add({
        'questionIndex': _questionIndex,
        'correctAnswer': answerScore,
      });

      // when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        setState(() {
          endOfQuiz = true;
          activeScreen = 'results-screen';
        });
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      // Pass the _totalScore to the ResultScreen when navigating.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            totalScore: _totalScore,
            maxScore: _questions.length,
          ),
        ),
      );
    }
  }

  String _getQuestionNumber() {
    return ' Question - ${_questionIndex + 1}/${_questions.length}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Grammar Quiz App',
          style: TextStyle(color: Colors.white),
        ),
        // centerTitle: true,
      ),
    
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16, top: 8),
                  
                  child: Text(
                    _getQuestionNumber(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      if (_scoreTracker.isEmpty)
                        const SizedBox(
                          height: 15.0,
                        ),
                      if (_scoreTracker.isNotEmpty) ..._scoreTracker
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
           const Divider(
              height: 8,
              thickness: 3,
              color: Colors.lightBlueAccent,
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
              (answer) => Answer(
                answerText: answer['answerText'] as String, // Convert to String
                answerColor: answerWasSelected
                    ? answer['score'] as bool
                        ? Colors.green
                        : Colors.red
                    : null,
                answerTap: () {
                  if (answerWasSelected) {
                    return;
                  }
                  _questionAnswered(answer['score'] as bool); // Convert to bool
                },
              ),
            ),
            const SizedBox(height: 2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40.0),
              ),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Please select an answer before going to the next question'),
                  ));
                  return;
                }
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Result Quiz' : 'Next Question'),
            ),
            const SizedBox(height: 6),
            if (answerWasSelected && !endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected
                        ? 'Well done, you got it right!'
                        : 'Wrong :/',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected
                        ? 'The Last Question - Well done !'
                        : 'The Last Question - Wrong :/',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

final List<Map<String, dynamic>> _questions = [
   {
    'question': 'Do not you dare ________ that vase',
   'answers': [
      {'answerText': 'touch', 'score': true},
      {'answerText': 'to touch', 'score': false},
      {'answerText': 'touched', 'score': false},
      {'answerText': 'touching', 'score': false},
    ],
   },
  {
    'question': 'My brother __________ actively involved  in voluntary work for over two years.',
   'answers': [
      {'answerText': 'has been', 'score': false},
      {'answerText': 'has been being', 'score': false},
      {'answerText': 'has been worked', 'score': true},
      {'answerText': 'have been', 'score': false},
    ],
  },
  {
    'question': 'The most distinctive characteristics of Min Htaw  is ______________.',
 'answers': [
      {'answerText': 'hospitality', 'score': false},
      {'answerText': 'hospital', 'score': false},
      {'answerText': 'hospitalization', 'score': false},
      {'answerText': 'hospitalize', 'score': true},
    ],
  },
  {
    'question': 'If your goal is to become a good programmer, you _________ your best.',
    'answers': [
      {'answerText': 'should try', 'score': false},
      {'answerText': 'should be tried', 'score': true},
      {'answerText': 'would try', 'score': false},
      {'answerText': 'might try', 'score': false},
    ],
  },
  {
'question': 'The full moon day of Thadingyut is the gazette day so we __________ the program course.',
  'answers': [
      {'answerText': 'do not need to attend', 'score': true},
      {'answerText': 'must not attend', 'score': false},
      {'answerText': 'cannot attend', 'score': false},
      {'answerText': 'could not attend', 'score': false},
    ],
  },
  {
      'question': 'It is hard ________ with others because you are not them.',
  'answers': [
      {'answerText': 'to empathize', 'score': false},
      {'answerText': 'empathy', 'score': false},
      {'answerText': 'empathizing', 'score': false},
      {'answerText': 'empathize', 'score': true},
    ],
  },
  {
      'question': 'Find the Adjective Phrase. "The man sitting in front of us is our MSI principal."',
 'answers': [
      {'answerText': 'sitting in front of us', 'score': false},
      {'answerText': 'our MSI principal', 'score': true},
      {'answerText': 'in front of us', 'score': false},
      {'answerText': 'in front of us', 'score': false},
    ],
  },
  {
       'question': 'Which one is the verb in the predicate of the sentence? HUAWEI phones made in China are very good.',
  'answers': [
      {'answerText': 'are good', 'score': false },
      {'answerText': 'made', 'score': false},
      {'answerText': 'are', 'score': true},
      {'answerText': 'are very good', 'score': false},
    ],
  },
  {
      'question':'Choose the correct answer. The boy said, "Aunt, go straight and turn left.',
 'answers': [
      {'answerText': 'The boy told his aunt to go straight and turn left.', 'score': true},
      {'answerText': 'The boy said that his aunt to go straight and turn left.', 'score': false},
      {'answerText': 'The boy told his aunt why she go straight and turn left.', 'score': false},
      {'answerText': 'The boy told his aunt not to go straight and turn left.', 'score': false},
    ],
  },
 {
  'question': 'We enjoyed the trip to Pyin Oo Lwin. It was really ___________.',
 'answers': [
      {'answerText': 'enjoyable', 'score': false},
      {'answerText': 'enjoy', 'score': false},
      {'answerText': 'enjoyment', 'score': true},
      {'answerText': 'enjoys', 'score': false},
    ],
 },
];
