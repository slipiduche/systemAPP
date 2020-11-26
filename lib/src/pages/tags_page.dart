import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class TagsPage extends StatefulWidget {
  TagsPage({Key key}) : super(key: key);

  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 26.0),
                      Container(
                        height: 123,
                        width: 123,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0)),
                        child: tagIcon(98.0, colorMedico),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Tags',
                        style: TextStyle(
                            color: colorVN,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 40.0),
                      tarjeta('Add tag', 'Add new tag',
                          addIcon(40, colorMedico), 11, context),
                      SizedBox(height: 20.0),
                      tarjeta('Edit tag', 'Edit a tag',
                          editIcon(40, colorMedico), 12, context),
                      SizedBox(height: 20.0),
                      tarjeta('Delete tag', 'Delete a tag',
                          deleteIcon(40, colorMedico), 13, context),
                    ],
                  ),
                ),
              ),
              gradientBar2(1),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(1),
      ),
    );
  }
}
