// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_00/homescreen.dart';

class StopScreen extends StatefulWidget {
  final AlarmSettings alarmSettings;

  const StopScreen({
    super.key,
    required this.alarmSettings,
  });

  @override
  State<StopScreen> createState() => _StopScreenState();
}

class _StopScreenState extends State<StopScreen> {
  List<String> words = ['hangman', 'dart', 'programming', 'language', 'code'];
  String secretWord = '';
  List<String> guessedLetters = [];
  int attempts = 6;

  @override
  void initState() {
    super.initState();
    secretWord = words[0].toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stop Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Welcome to Hangman!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Attempts left: $attempts',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Secret Word: ${displayWord(secretWord, guessedLetters)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Guessed Letters: ${guessedLetters.join(', ')}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            if (attempts > 0 && !isWordGuessed(secretWord, guessedLetters))
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      autofocus: true,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          makeGuess(value.toLowerCase());
                        }
                      },
                    ),
                    TextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      autofocus: true,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          makeGuess(value.toLowerCase());
                        }
                      },
                    ),
                    TextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      autofocus: true,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          makeGuess(value.toLowerCase());
                        }
                      },
                    ),
                    TextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      autofocus: true,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          makeGuess(value.toLowerCase());
                        }
                      },
                    ),
                    TextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      autofocus: true,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          makeGuess(value.toLowerCase());
                        }
                      },
                    ),
                  ],
                ),
              )
            else if (isWordGuessed(secretWord, guessedLetters))
              Column(
                children: [
                  Text(
                    'Congratulations! You guessed the word: $secretWord',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Alarm.stop(widget.alarmSettings.id)
                          .then((_) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              )));
                    },
                    child: Text('Stop'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Text(
                    'Sorry, you ran out of attempts. The word was: $secretWord',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      resetGame();
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
          ]),
        ),
      ),
    );
  }

  String displayWord(String secretWord, List<String> guessedLetters) {
    String display = '';
    for (var letter in secretWord.runes) {
      String char = String.fromCharCode(letter);
      if (guessedLetters.contains(char)) {
        display += char;
      } else {
        display += '_';
      }
    }
    return display;
  }

  bool isWordGuessed(String secretWord, List<String> guessedLetters) {
    for (var letter in secretWord.runes) {
      String char = String.fromCharCode(letter);
      if (!guessedLetters.contains(char)) {
        return false;
      }
    }
    return true;
  }

  void makeGuess(String guess) {
    setState(() {
      if (!guessedLetters.contains(guess)) {
        guessedLetters.add(guess);

        if (!secretWord.contains(guess)) {
          attempts--;

          if (attempts == 0) {}
        }
      }
    });
  }

  void resetGame() {
    setState(() {
      secretWord = words[0].toLowerCase();
      guessedLetters.clear();
      attempts = 6;
    });
  }
}
