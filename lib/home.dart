
import 'dart:math';

import 'package:dream_walk/sharedMoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  int _getRandomMoney = 0;

  // 버튼 활성상태(0: 비활성, 1:작은보상, 2:완료보상)
  int _isButtonOn = 0;
  Color _buttonColor = Colors.grey;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nowMoney = _prefs.getInt('myMoney') ?? 0;
      _nowDay = _prefs.getInt('myDay') ?? 0;
      _nowSleep = _prefs.getString('mySleep') ?? "00:00";
    });
  }

  Future<void> _addMoney(int value) async{
    setState(() {
      _nowMoney += value;
    });
    await _prefs.setInt('myMoney', _nowMoney);
  }

  Future<void> _changeTime(String value) async{
    setState(() {
    });
    await _prefs.setString('mySleep', value);
  }

  Future<void> _addCount(int count) async {
    setState(() {
      _nowDay++;
    });
    await _prefs.setInt('myDay', _nowDay);
  }

  void _openModal() {
    _getRandomMoney = Random().nextInt(30) + 1;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5, // 화면의 50% 너비로 설정
              height: MediaQuery.of(context).size.height * 0.3, // 화면의 50% 너비로 설정
              child: Image.asset('lib/assets/randombox.jpg', fit:BoxFit.cover,),
            ),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                _openTextModal();
              });
            },
          ),
        );
      },
    );
  }

  void _openTextModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5, // 화면의 50% 너비로 설정
              height: MediaQuery.of(context).size.height * 0.3, // 화면의 50% 너비로 설정
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Text('$_getRandomMoney point 획득!!'
                      '(클릭시 닫기)'),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                _isButtonDisabled = true;
                _addMoney(_getRandomMoney);
              });
            },
          ),
        );
      },
    );
  }

  void _openAdModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5, // 화면의 50% 너비로 설정
              child: Image.asset('lib/assets/ad.png', fit:BoxFit.cover,),
            ),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                _openModal();
                //_isButtonDisabled = true;
                // _addMoney(_getRandomMoney);
              });
            },
          ),
        );
      },
    );
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          // 버튼 클릭 이벤트 처리
                          DateTime now = DateTime.now();
                          // 5시부터 9시 사이의 랜덤한 시간 생성
                          DateTime startTime = DateTime(now.year, now.month, now.day, 7);
                          DateTime endTime = DateTime(now.year, now.month, now.day, 9);
                          Duration randomDuration = Duration(minutes: Random().nextInt(endTime.difference(startTime).inMinutes));
                          DateTime randomTime = startTime.add(randomDuration);

                          // HH:MM:SS 형식으로 변환
                          String formattedTime = DateFormat('HH:mm:ss').format(randomTime);

                          _nowSleep = formattedTime;

                          if (randomTime.hour >= 6 && randomTime.hour < 7) {
                            _buttonColor = Colors.lightGreenAccent;
                            _isButtonOn = 1;
                            _isButtonDisabled = false;
                          } else if (randomTime.hour >= 7 && randomTime.hour < 9) {
                            _buttonColor = Colors.yellow;
                            _isButtonOn = 2;
                            _isButtonDisabled = false;
                          } else if (randomTime.hour >= 9 && randomTime.hour < 10) {
                            _buttonColor = Colors.lightGreenAccent;
                            _isButtonOn = 1;
                            _isButtonDisabled = false;
                          } else {
                            _buttonColor = Colors.grey;
                            _isButtonOn = 0;
                            _isButtonDisabled = true;
                          }
                          _changeTime(formattedTime);

                          //print(formattedTime);
                        },
                        child: Text('reset time button for test'),
                      ),
                    ),
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
                        child: ElevatedButton(
                          onPressed: _isButtonDisabled ? null : () {
                            // 버튼이 클릭되었을 때 수행할 작업
                            if(_isButtonOn == 2) {
                              // 완료보상
                              _openAdModal();
                              bool isRewardOpen = false;

                              _addCount(_nowDay);
                            } else if(_isButtonOn == 1) {
                              // 작은보상
                              _openAdModal();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _buttonColor,
                          ),
                          child: Text('reward'),
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