import 'dart:collection';

import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  //Dart has lists, works like an array
  //Notice that widgets which accept multiple children actually accept Lists
  List<Icon> scoreKeeper = [];

  Map<String, bool> questions = {
    'You can lead a cow down stairs but not up stairs.': false,
    'Approximately one quarter of human bones are in the feet.': true,
    'A slug\'s blood is green.': true
  };

  int questionNumber = 0;

  void advanceQuestions() {
    if (questionNumber < questions.length - 1) {
      questionNumber++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions.keys.elementAt(questionNumber),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.green,
                ),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //needs this wrapper, as it will trigger a UI change
                setState(() {
                  bool _key = questions.values.elementAt(questionNumber);
                  if (_key == true) {
                    print('Correct');
                  } else {
                    print('Incorrect');
                  }

                  advanceQuestions();
                });
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.red,
                ),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  advanceQuestions();
                });
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          //'children' property wants a list of type <widget>, scoreKeeper **is** a list of type <icon>, which is a widget, so this works fine
          //Note that we could choose not to specify a type, and just leave it as a plain 'dynamic' list
          //Just safer to specify the type - means we can't go wrong, it won't let us
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
