import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
 void _moveTo(index, context)async{
if (index == 0) {
      await Navigator.pushReplacementNamed(context, 'roomsPage',
          arguments: null);
    }

    if (index == 1) {
      await Navigator.pushReplacementNamed(context, 'tagPage', arguments: null);
    }
    if (index == 2) {
      await Navigator.pushReplacementNamed(context, 'homePage',
          arguments: null);
    }
    if (index == 3) {
      await Navigator.pushReplacementNamed(context, 'musicPage',
          arguments: null);
    }
}

Widget tarjeta(String label, description, Widget icon,int index,dynamic context ) {
  return GestureDetector(
      
      child: Card(
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
            width: 23.48,
          )
        ]),
      ),
    ),
    onTap: ()async{
      if (index == 5) {
      await Navigator.pushReplacementNamed(context, 'addSongsPage',
          arguments: null);
    }

    if (index == 1) {
      await Navigator.pushReplacementNamed(context, 'tagPage', arguments: null);
    }
    if (index == 2) {
      await Navigator.pushReplacementNamed(context, 'homePage',
          arguments: null);
    }
    if (index == 3) {
      await Navigator.pushReplacementNamed(context, 'musicPage',
          arguments: null);
    }
    },
  );
}

Widget gradientBar(bool selected) {
  if (selected) {
    return Container(
      height: 10.0,
      width: 90,
      decoration: BoxDecoration(
        //color: colorMedico,
        gradient: gradiente,
      ),
    );
  } else {
    return Container(
      height: 10.0,
      width: 90,
      color: colorBackGround,
    );
  }
}

Widget gradientBar2(int index) {
  return Container(
    height: 10.0,
    width: double.infinity,
    child: Row(
      children: [
        gradientBar(index == 0),
        Expanded(child: Container()),
        gradientBar(index == 1),
        Expanded(child: Container()),
        gradientBar(index == 2),
        Expanded(child: Container()),
        gradientBar(index == 3),
      ],
    ),
  );
}

class BottomBar extends StatefulWidget {
  
  int index;
  BottomBar(this.index,{Key key} ) : super(key: key);
  

  @override
  _BottomBarState createState() => _BottomBarState(index);
}

class _BottomBarState extends State<BottomBar> {
  int _itemselected;
  _BottomBarState( this._itemselected );
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

  void _onItemTapped(index) async {
    _itemselected = index;
    print('presionaste:');
    print(index);
    if (index == 0) {
      await Navigator.pushReplacementNamed(context, 'roomsPage',
          arguments: null);
    }

    if (index == 1) {
      await Navigator.pushReplacementNamed(context, 'tagPage', arguments: null);
    }
    if (index == 2) {
      await Navigator.pushReplacementNamed(context, 'homePage',
          arguments: null);
    }
    if (index == 3) {
      await Navigator.pushReplacementNamed(context, 'musicPage',
          arguments: null);
    }
    
  }
}
