import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

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
                  color: backgroundGrey,
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGreyDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
