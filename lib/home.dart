// tabs/tab_cart.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 상단
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                // 15% 크기의 이미지 영역
                Expanded(
                  flex: 15,
                  child: LayoutBuilder(
                    builder:(BuildContext context, BoxConstraints constraints) {
                      double imageSize = constraints.maxWidth < constraints.maxHeight
                          ? constraints.maxWidth
                          : constraints.maxHeight;
                      return Container(
                        width: imageSize,
                        height: imageSize,
                        child: Image.asset('lib/assets/logo.png'),
                      );
                    },
                  ),
                ),
                // 60% 크기의 텍스트 영역
                Expanded(
                  flex:68,
                  child: Container(
                    child: Center(
                      child: Expanded(
                        child: Container(
                          child: LayoutBuilder(
                            builder:(BuildContext context, BoxConstraints constraints) {
                              double BoxWidth = constraints.maxWidth * 0.7;
                              double BoxHeight = constraints.maxHeight * 0.4;
                              return Container(
                                width: BoxWidth,
                                height: BoxHeight,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Container()
                                    ),
                                    Expanded(
                                      flex: 6, // 왼쪽 여백을 부모의 20%로 설정
                                      child: Container(
                                        child: Text(
                                          '10000',
                                          style: TextStyle(fontSize: 34),
                                          textAlign: TextAlign.right, // 텍스트를 우측으로 정렬
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2, // 오른쪽 여백을 부모의 20%로 설정
                                      child: Container(
                                        child: Text(
                                          'P',
                                          style: TextStyle(fontSize: 34),
                                          textAlign: TextAlign.right, // 텍스트를 우측으로 정렬
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container()
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // 15% 크기의 버튼 영역
                Expanded(
                  flex: 20,
                  child: Center(
                    child: LayoutBuilder(
                      builder:(BuildContext context, BoxConstraints constraints) {
                        double BoxWidth = constraints.maxWidth * 0.7;
                        double BoxHeight = constraints.maxHeight * 0.6;
                        return Container(
                          width: BoxWidth,
                          height: BoxHeight,
                          child: InkWell(
                            onTap: () {
                              // 버튼이 클릭되었을 때 수행할 작업
                            },
                            borderRadius: BorderRadius.circular(100.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.black,
                                size: BoxWidth,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ),
          // 중단
          Expanded(
            flex: 6,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 0.6 * MediaQuery.of(context).size.width,
                      height: 0.2 * MediaQuery.of(context).size.height,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: Text(
                            '10000',
                            style: TextStyle(fontSize: 36),
                          ),
                        ),
                      ),
                    ),// 원하는 크기로 조정
                    Container(
                      alignment: Alignment.topRight,
                      width: 0.25 * MediaQuery.of(context).size.width,
                      height: 0.06 * MediaQuery.of(context).size.height,
                      color: Colors.yellow,
                      child: Center(
                        child: Text(
                          'Day + 6',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 하단
          Expanded(
            flex: 2,
            child: Container(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double buttonWidth = constraints.maxWidth * 0.4; // Container 너비의 25%
                  double buttonHeight = constraints.maxHeight * 0.5; // Container 높이의 50%
                  return Container(
                    child: Center(
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.green,
                        child: ElevatedButton(
                          onPressed: () {
                            // 버튼이 클릭되었을 때 수행할 작업
                          },
                          style: ElevatedButton.styleFrom(

                          ),
                          child: Text('Button'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // 배너광고
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}