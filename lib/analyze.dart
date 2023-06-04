// tabs/tab_cart.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Analyze extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StyledButton(
                buttonText: '평균 수면 시간',
                onPressed: () {
                  // 버튼 1을 눌렀을 때 수행할 작업
                  print('11');
                },
              ),
              StyledButton(
                buttonText: '그 외 기능1(추가 예정)',
                onPressed: () {
                  // 버튼 1을 눌렀을 때 수행할 작업
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('추가 예정 입니다 🤗', textAlign: TextAlign.center),
                      );
                    },
                  );
                },
              ),
              StyledButton(
                buttonText: '그 외 기능2(추가 예정)',
                onPressed: () {
                  // 버튼 1을 눌렀을 때 수행할 작업
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('추가 예정 입니다 🤗', textAlign: TextAlign.center),
                      );
                    },
                  );
                },
              ),
              StyledButton(
                buttonText: '그 외 기능3(추가 예정)',
                onPressed: () {
                  // 버튼 1을 눌렀을 때 수행할 작업
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('추가 예정 입니다 🤗', textAlign: TextAlign.center),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  StyledButton({required this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}