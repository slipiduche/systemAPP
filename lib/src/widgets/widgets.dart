import 'package:flutter/material.dart';
import 'package:systemAPP/src/icons/icons.dart';

Widget tarjeta(String label, description, Widget icon) {
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Container(
      height: 105,
      child: Row(children: [
        SizedBox(width: 30.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36.0,
                  fontWeight: FontWeight.w100),
            ),
            Text(
              description,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w100),
            )
          ],
        ),
        Expanded(child: Container()),
        icon,
        SizedBox(
          width: 43.48,
        )
      ]),
    ),
  );
}

class BotomBar extends StatefulWidget {
  BotomBar({Key key}) : super(key: key);

  @override
  _BotomBarState createState() => _BotomBarState();
}

class _BotomBarState extends State<BotomBar> {
  int _itemselected = 0;
  @override
  Widget build(BuildContext context) {
    return botomBar();
  }

  Widget botomBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: roomBarIcon(25),
            title: Container(),
            activeIcon: roomBarIconS(25)),
        BottomNavigationBarItem(
            icon: tagBarIcon(25),
            title: Container(),
            activeIcon: tagBarIconS(25)),
        BottomNavigationBarItem(
          icon: homeBarIcon(25),
          title: Container(),
        ),
        BottomNavigationBarItem(
            icon: musicBarIcon(25),
            title: Container(),
            activeIcon: musicBarIconS(25)),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _itemselected,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(index) {
    _itemselected = index;
    print('presionaste:');
    print(index);

    setState(() {});
  }
}
