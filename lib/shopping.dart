// tabs/tab_cart.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  late SharedPreferences _prefs;
  int _nowMoney = 0;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nowMoney = _prefs.getInt('myMoney') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0x800080),
        appBar: AppBar(
          title: Text('보유 Point : $_nowMoney'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.account_balance_wallet),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Wrap(
                spacing: 16.0, // 열 사이의 간격
                runSpacing: 20.0, // 행 사이의 간격
                children: [
                  BoxItem(
                    imagePath: 'lib/assets/candy.jpg',
                    title: '츄파춥스',
                    points: 300,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/mega.jpg',
                    title: '메가커피',
                    points: 2000,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/twosome.jpg',
                    title: '투썸플레이스',
                    points: 4500,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/starbucks.jpg',
                    title: '스타벅스',
                    points: 4500,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/moonsang.jpg',
                    title: '문화상품권',
                    points: 3000,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/moonsang.jpg',
                    title: '문화상품권',
                    points: 5000,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/moonsang.jpg',
                    title: '문화상품권',
                    points: 10000,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/happy_money.jpg',
                    title: '해피머니',
                    points: 3000,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/happy_money.jpg',
                    title: '해피머니',
                    points: 5000,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/happy_money.jpg',
                    title: '해피머니',
                    points: 10000,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/dogecoin.jpg',
                    title: '도지',
                    points: 88,
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/dogecoin.jpg',
                    title: '도지',
                    points: 88,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BoxItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final int points;

  BoxItem({
    required this.imagePath,
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          // 버튼 1을 눌렀을 때 수행할 작업
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content:
                Text('업데이트 후 구매 가능합니다 🤗', textAlign: TextAlign.center),
              );
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$points p',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
    );
  }
}
