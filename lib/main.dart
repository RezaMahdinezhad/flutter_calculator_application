import 'package:flutter/material.dart';

import 'constants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApplication());
}

class CalculatorApplication extends StatefulWidget {
  CalculatorApplication({Key? key}) : super(key: key);

  @override
  State<CalculatorApplication> createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {
  var inputUser = '';
  var result = '';
  var x = 0;
  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
              ),
              backgroundColor: getButtonBackgroundcolor(text1)),
          onPressed: () {
            if (text1 == 'ac') {
              if (inputUser.length > 0) {
                setState(() {
                  inputUser = '';
                  result = '';
                });
              }
              setState(() {
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: EdgeInsetsDirectional.all(3),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getButtonTextcolor(text1),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
              ),
              backgroundColor: getButtonBackgroundcolor(text2)),
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsetsDirectional.all(3),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getButtonTextcolor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
              ),
              backgroundColor: getButtonBackgroundcolor(text3)),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: EdgeInsetsDirectional.all(3),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getButtonTextcolor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
              ),
              backgroundColor: getButtonBackgroundcolor(text4)),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsetsDirectional.all(3),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getButtonTextcolor(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: textGreen,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          result,
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 62,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('ac', 'ce', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var element in list) {
      if (element == text) {
        return true;
      }
    }
    return false;
  }

  Color getButtonBackgroundcolor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getButtonTextcolor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
