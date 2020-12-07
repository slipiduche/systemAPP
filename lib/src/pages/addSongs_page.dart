import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/provider/file_provider.dart';

class AddSongsPage extends StatefulWidget {
  AddSongsPage({Key key}) : super(key: key);

  @override
  _AddSongsPageState createState() => _AddSongsPageState();
}

class _AddSongsPageState extends State<AddSongsPage> {
  
  
  @override
  Widget build(BuildContext context) {
    awaitUpload=0;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: colorBackGround,
          child: Column(
            children: [
              Container(
                  height: 10.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: gradiente,
                  )),
              SizedBox(height: 26.0),
              Container(
                height: 123,
                width: 123,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0)),
                child: songIcon(98.0, colorMedico),
              ),
              SizedBox(height: 8.0),
              Text(
                'Songs',
                style: TextStyle(
                    color: colorVN,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30.0),
              Expanded(
                child:Container(
                        //height: 200.0,
                        //width: double.infinity,

                        child: FilePickerDemo(true,"Select the songs you want to add", "Search for songs"),
                      ),
                  
              ),
              gradientBar2(3),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(3),
      ),
    );
  }
}
