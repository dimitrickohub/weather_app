import 'package:flutter/material.dart';

const String _kToday = 'Today';

class TodayAppBar extends StatelessWidget {
  const TodayAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      bottom: PreferredSize(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.repeated,
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.pink,
                  Colors.orange,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.red,
                ],
              ),
            ),
            height: 4.0,
          ),
          preferredSize: const Size.fromHeight(4.0)),
      title: const SafeArea(
        child: Center(
          child: Text(
            _kToday,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
