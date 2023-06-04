// tabs/tab_cart.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('10000P'),
          centerTitle: true,
          backgroundColor: Colors.blue,
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
                    imagePath: 'lib/assets/partner4.jpg',
                    title: '침팬치와 뽀뽀하기',
                    points: '1000P',
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/partner3.jpg',
                    title: '오랑우탄 방구맡기',
                    points: '2000P',
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/partner2.jpg',
                    title: '고릴라와 데이트',
                    points: '5000p',
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/partner1.jpg',
                    title: '+1(더블데이트)',
                    points: '8000P',
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/dogecoin.jpg',
                    title: '도지',
                    points: '100P',
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/dogecoin.jpg',
                    title: '도지',
                    points: '100P',
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/dogecoin.jpg',
                    title: '도지',
                    points: '100P',
                  ),
                  BoxItem(
                    imagePath: 'lib/assets/dogecoin.jpg',
                    title: '도지',
                    points: '100P',
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
  final String points;

  BoxItem({
    required this.imagePath,
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          points,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
