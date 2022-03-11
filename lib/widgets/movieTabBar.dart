import 'package:flutter/material.dart';

class MovieTabBar extends StatefulWidget {
  const MovieTabBar({Key? key}) : super(key: key);

  @override
  _MovieTabBarState createState() => _MovieTabBarState();
}

class _MovieTabBarState extends State<MovieTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        child: Column(
          children: [
            Container(
              child: TabBar(
                  tabs: [
                    Text('Movies'),
                    Text('Tv Shows')
                  ]),
            ),
            SingleChildScrollView(
              child: TabBarView(
                children: [
                  Text('hello'),
                  Text('hello'),
                ],
              ),
            )
          ],
        )
    );
  }
}
