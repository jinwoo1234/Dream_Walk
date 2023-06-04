
import 'package:dream_walk/sharedMoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences _prefs;
  int _nowMoney = 0;
  int _nowDay = 0;
  String _nowSleep = "";

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nowMoney = _prefs.getInt('myMoney') ?? 1233;
      _nowDay = _prefs.getInt('myDay') ?? 2;
      _nowSleep = _prefs.getString('mySleep') ?? "6:00";
    });

  }

  Future<void> _addData(String name, int value) async{
    setState(() {
      print("add");
    });
    await _prefs.setInt(name, value);
  }

  Future<void> _addCount(int count) async {
    setState(() {
      _nowDay++;
    });
    await _prefs.setInt('myDay', _nowDay);
  }

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
                // 가운데 돈 영역
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
                                          '$_nowMoney',
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
                // 사용자페이지 영역
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content:
                                    Text('사용자 설정 페이지 추가 예정 입니다 🤗', textAlign: TextAlign.center),
                                  );
                                },
                              );
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
                            _nowSleep,
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
                          'Day + $_nowDay',
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
                            _addCount(_nowDay);
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