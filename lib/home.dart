
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

  //시나리오용
  int _testIndex = 0;
  int _testStartTime = 0;
  int _testEndTime = 0;

  int _getRandomMoney = 0;

  // 버튼 활성상태(0: 비활성, 1:작은보상, 2:완료보상)
  int _isButtonOn = 0;
  Color _buttonColor = Colors.grey;
  bool _isButtonDisabled = false;
  int _bonusMoney = 0;

  int _randomMoneyRangeSet = 0;
  int _randomMoneyRangeStart = 0;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
    if(_nowDay >= 13) {
      _bonusMoney = 50;
    } else if(_nowDay == 12) {
      _bonusMoney = 45;
    }else if(_nowDay == 11) {
      _bonusMoney = 40;
    }else if(_nowDay == 10) {
      _bonusMoney = 35;
    }else if(_nowDay == 9) {
      _bonusMoney = 30;
    }else if(_nowDay == 8) {
      _bonusMoney = 25;
    }else if(_nowDay == 7) {
      _bonusMoney = 20;
    }else if(_nowDay == 6) {
      _bonusMoney = 15;
    }else if(_nowDay == 5) {
      _bonusMoney = 10;
    }else if(_nowDay == 4) {
      _bonusMoney = 5;
    }
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

  Future<void> _addCount() async {
    setState(() {
      _nowDay++;
    });
    await _prefs.setInt('myDay', _nowDay);
  }

  Future<void> _resetCount() async {
    setState(() {
      _nowDay = 0;
      _bonusMoney;
    });
    await _prefs.setInt('myDay', _nowDay);
  }

  void _openModal() {
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
                  child: _bonusMoney == 0 ? Text('$_getRandomMoney point 획득!!\n(클릭시 닫기)') : Text('$_getRandomMoney + $_bonusMoney point 획득!!\n(클릭시 닫기)'),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                _isButtonDisabled = true;
                _buttonColor = Colors.grey;
                _addMoney(_getRandomMoney + _bonusMoney);
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
              });
            },
          ),
        );
      },
    );
  }

  void _changeRandomMoney() {
    if(_nowDay >= 13) {
      _bonusMoney = 50;
    } else if(_nowDay == 12) {
      _bonusMoney = 45;
    }else if(_nowDay == 11) {
      _bonusMoney = 40;
    }else if(_nowDay == 10) {
      _bonusMoney = 35;
    }else if(_nowDay == 9) {
      _bonusMoney = 30;
    }else if(_nowDay == 8) {
      _bonusMoney = 25;
    }else if(_nowDay == 7) {
      _bonusMoney = 20;
    }else if(_nowDay == 6) {
      _bonusMoney = 15;
    }else if(_nowDay == 5) {
      _bonusMoney = 10;
    }else if(_nowDay == 4) {
      _bonusMoney = 5;
    }
    if(_randomMoneyRangeSet != 0) {
      _getRandomMoney = Random().nextInt(_randomMoneyRangeSet) + _randomMoneyRangeStart;
    } else {
      _getRandomMoney = _randomMoneyRangeStart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(95 , 4, 180, 1),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 2.0],
            colors: [
              Color.fromRGBO(68, 3, 93, 1),
              Color.fromRGBO(53, 162, 255, 1),
            ],
          ),
        ),
        child : Column(
            children: [
              // 상단
              Expanded(
                flex: 3,
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
                                      color: Color.fromRGBO(155, 190, 123, 1.0),
                                      border: Border.all(
                                        color: Color.fromRGBO(
                                            67, 79, 63, 1.0),

                                        width: 4,
                                      ),
                                      borderRadius: BorderRadius.circular(2.0),
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
                                              style: TextStyle(fontSize: 32, color:Color.fromRGBO(
                                                  55, 77, 42, 1.0),),
                                              textAlign: TextAlign.right, // 텍스트를 우측으로 정렬
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2, // 오른쪽 여백을 부모의 20%로 설정
                                          child: Container(
                                            child: Text(
                                              'P',
                                              style: TextStyle(fontSize: 34, color:Color.fromRGBO(
                                                  55, 77, 42, 1.0),),
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
                                    color:Colors.white,
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
                flex: 7,
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate (
                          offset: Offset(0.0, -60.0), // 버튼 주위에 외부 간격을 추가합니다.
                          child: ElevatedButton(
                            onPressed: () {

                              if(_testIndex < 10) {
                                _testStartTime = 7;
                                _testEndTime = 9;
                              } else if(_testIndex == 10){
                                _testStartTime = 6;
                                _testEndTime = 7;
                              } else {
                                _testStartTime = 4;
                                _testEndTime = 6;
                                _resetCount();
                              }

                              _testIndex++;



                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      // 버튼 클릭 이벤트 처리
                                      DateTime now = DateTime.now();
                                      // 5시부터 9시 사이의 랜덤한 시간 생성
                                      DateTime startTime = DateTime(now.year, now.month, now.day, _testStartTime);
                                      DateTime endTime = DateTime(now.year, now.month, now.day, _testEndTime);
                                      Duration randomDuration = Duration(minutes: Random().nextInt(endTime.difference(startTime).inMinutes));
                                      DateTime randomTime = startTime.add(randomDuration);

                                      // HH:MM:SS 형식으로 변환
                                      String formattedTime = DateFormat('HH:mm:ss').format(randomTime);

                                      _nowSleep = formattedTime;

                                      if (randomTime.hour >= 6 && randomTime.hour < 7) {
                                        _buttonColor = Color.fromRGBO(72 , 40, 28, 1);
                                        _isButtonOn = 1;
                                        _isButtonDisabled = false;
                                        _randomMoneyRangeSet = 10;
                                        _randomMoneyRangeStart = 0;
                                      } else if (randomTime.hour >= 7 && randomTime.hour < 9) {
                                        _buttonColor = Color.fromRGBO(255, 235, 59, 0.85);
                                        _isButtonOn = 2;
                                        _isButtonDisabled = false;
                                        _randomMoneyRangeSet = 0;
                                        _randomMoneyRangeStart = 50;
                                      } else if (randomTime.hour >= 9 && randomTime.hour < 10) {
                                        _buttonColor = Color.fromRGBO(72 , 40, 28, 1);
                                        _isButtonOn = 1;
                                        _isButtonDisabled = false;
                                        _randomMoneyRangeSet = 10;
                                        _randomMoneyRangeStart = 0;
                                      } else {
                                        _buttonColor = Colors.grey;
                                        _isButtonOn = 0;
                                        _isButtonDisabled = true;
                                        _randomMoneyRangeSet = 0;
                                        _randomMoneyRangeStart = 0;
                                      }
                                      _changeRandomMoney();
                                      _changeTime(formattedTime);

                                      Navigator.of(context).pop(); // 화면을 탭하면 모달을 닫습니다.
                                    },
                                    child: Container (
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  );
                                },
                              );
                              //print(formattedTime);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16.0),
                              minimumSize: Size(150.0, 80.0),
                              backgroundColor: Colors.deepPurpleAccent,
                            ),
                            child: Text('수면 모드'),
                          ),
                        ),
                        Container(
                          width: 0.6 * MediaQuery.of(context).size.width,
                          height: 0.2 * MediaQuery.of(context).size.height,
                          child: Container(
                            decoration: BoxDecoration(
                              color:Color.fromRGBO(
                                  220, 220, 220, 0.803921568627451),
                              border: Border.all(
                                color: Colors.black,
                                width: 0,
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
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(234, 221, 97,
                                0.8666666666666667),
                            border: Border.all(
                              color: Colors.black,
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(10.0), // 원하는 둥글기 값을 여기에 설정합니다.
                          ),
                          child: Center(
                            child: Text(
                              'Day + $_nowDay',
                              style: TextStyle(fontSize: 16, color:Colors.black,),
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
                      int maxPoint = _randomMoneyRangeStart + _randomMoneyRangeSet;
                      double buttonWidth = constraints.maxWidth * 0.6; // Container 너비의 25%
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
                                  _addCount();
                                } else if(_isButtonOn == 1) {
                                  // 작은보상
                                  _bonusMoney = 0;
                                  _openAdModal();
                                  _resetCount();
                                } else {
                                  _resetCount();
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      return _buttonColor; // 비활성화 상태일 때 적용할 색상
                                    }
                                    return _buttonColor; // 활성화 상태일 때 적용할 색상
                                  },
                                ),
                              ),
                              child: _bonusMoney == 0 ? Container(
                                child: _randomMoneyRangeSet != 0 ?
                                Text('reward ($_randomMoneyRangeStart ~ $maxPoint) points', style: TextStyle(fontSize: 17),) :
                                Text('reward ($_randomMoneyRangeStart) points', style: TextStyle(fontSize: 17),
                                ),
                              ) : Container(
                                child: _randomMoneyRangeSet != 0 ?
                                Text('reward ($_randomMoneyRangeStart ~ $maxPoint) points', style: TextStyle(fontSize: 17),) :
                                Text('reward ($_randomMoneyRangeStart + $_bonusMoney) points', style: TextStyle(fontSize: 17),
                                ),
                              ),
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
                child: Image(
                  image: AssetImage('lib/assets/banner.jpg'),
                ),
              ),
            ],
          ),

      ),
    );
  }
}