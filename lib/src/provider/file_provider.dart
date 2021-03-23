import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:id3/id3.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/provider/upload_provider.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  bool multiple;
  String _text1, _text2;
  FilePickerDemo(this.multiple, this._text1, this._text2, {Key key})
      : super(key: key);
  _FilePickerDemoState createState() =>
      _FilePickerDemoState(multiple, _text1, _text2);
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  bool _multiPick;
  String _text1, _text2;
  _FilePickerDemoState(
    this._multiPick,
    this._text1,
    this._text2,
  );
  List uploadList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension = 'mp3';
  bool _loadingPath = false;
  //bool _multiPick = _multiple;
  FileType _pickingType = FileType.custom;
  TextEditingController _controller = TextEditingController();
  ScrollController controller;

  @override
  void initState() {
    //WidgetsBinding.instance.addPostFrameCallback(autoScroll);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clearCachedFiles();

      _openFileExplorer();
    });

    _controller.addListener(() => _extension = _controller.text);
    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        // _agregar10();
        print("llego al final");
      }
    });
    //     );
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: _multiPick,
        allowedExtensions: ['mp3'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      print("borrada cache");
    });
  }

  void autoScroll(index) async {
    print(index);
    double aux = index * 100.0;
    print(aux);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.animateTo(aux,
          curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));
      print('autoScroll');
    });
  }

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _text1,
              style: TextStyle(fontSize: title2),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 28.0),
              //padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _clearCachedFiles();

                      _openFileExplorer();
                    },
                    child: Container(
                      height: 41.0,

                      //width: MediaQuery.of(context).size.width - 52.0,
                      child: Container(
                          //margin: EdgeInsets.symmetric(horizontal: 0),
                          //expanded
                          child: Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              _text2,
                              style: TextStyle(
                                  color: colorLetraSearch, fontSize: search1),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          searchIcon(20.0, colorMedico),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                          border: Border.all(
                            color: colorBordeSearch,
                            style: BorderStyle.solid,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Builder(
                builder: (BuildContext context) => _loadingPath
                    ? Column(
                        children: [
                          Container(
                            //padding: const EdgeInsets.only(bottom: 10.0),
                            child: const CircularProgressIndicator(),
                          ),
                          Expanded(child: Container()),
                        ],
                      )
                    : _directoryPath != null
                        ? ListTile(
                            title: Text('Directory path'),
                            subtitle: Text(_directoryPath),
                          )
                        : _paths != null
                            ? Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      controller: controller,
                                      child: Builder(
                                        builder: (BuildContext context) {
                                          final itemCount = _paths != null &&
                                                  _paths.isNotEmpty
                                              ? _paths.length
                                              : 1;
                                          final bool isMultiPath =
                                              _paths != null &&
                                                  _paths.isNotEmpty;
                                          List<Widget> column = [Container()];

                                          for (var i = 0; i < itemCount; i++) {
                                            final path = _paths
                                                .map((e) => e.path)
                                                .toList()[i]
                                                .toString();
                                            final _selected = i;
                                            MP3Instance id3 =
                                                MP3Instance(_paths[i].path);
                                            String author, genre;
                                            if (id3.parseTagsSync()) {
                                              print(id3.getMetaTags());
                                              author = id3.metaTags["Artist"];
                                              genre = id3.metaTags["Genre"];
                                              print(author);
                                            }

                                            // print(author);
                                            if (author == null) {
                                              author = "Unknown";
                                            }
                                            if (genre == null) {
                                              genre = "Unknown";
                                            }
                                            print(author);
                                            uploadList.add({
                                              "name": _paths[i].name,
                                              "path": _paths[i].path,
                                              "artist": author.substring(
                                                  0, author.length),
                                              "genre": genre
                                            });
                                            if (_multiPick == false) {
                                              print('dibujar icono');
                                              column.add(TwoIconCard(
                                                  _paths[i].name,
                                                  author,
                                                  songIcon(40.0, colorMedico),
                                                  uploadIcon(40.0, colorMedico),
                                                  path,
                                                  context,
                                                  _paths[i].name,
                                                  genre));
                                            } else {
                                              print('dejar vacío');
                                              column.add(TwoIconCard(
                                                  _paths[i].name,
                                                  author,
                                                  songIcon(40.0, colorMedico),
                                                  false,
                                                  path,
                                                  context,
                                                  _paths[i].name,
                                                  genre));
                                              if (i == (itemCount - 1)) {
                                                column.add(GestureDetector(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      3.0),
                                                          height: 40.0,
                                                          // width: MediaQuery.of(
                                                          //             context)
                                                          //         .size
                                                          //         .width -
                                                          //     30,
                                                          child: Container(
                                                            child: RaisedButton(
                                                                child: Text(
                                                                  'Upload',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          22.0,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                    side: BorderSide(
                                                                        color:
                                                                            colorMedico)),
                                                                elevation: 4.0,
                                                                color:
                                                                    colorMedico,
                                                                onPressed: () =>
                                                                    sendSongs(
                                                                        itemCount)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                                column.add(SizedBox(
                                                  height: 20.0,
                                                ));
                                                print(itemCount);

                                                autoScroll(itemCount * 1.0);
                                              }
                                            }
                                          }

                                          return Column(
                                            children: column,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Expanded(child: const SizedBox()),
                                ],
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendSongs(songsCount) async {
    print('enviando');
    uploading(0, songsCount, context);
    int sendsCount = 0, sended = 0;

    for (var i = 0; i < songsCount; i++) {
      sended = await ServerDataBloc().uploadSong(_paths[i].path, _paths[i].name,
          uploadList[i]["artist"], uploadList[i]["genre"]);
      if (sended == 2) {
        sendsCount++;
        sended = 0;
        Navigator.pop(context);
        uploading(sendsCount, songsCount, context);
      }
    }
    if (sendsCount == songsCount) {
      print('enviadas');
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
              insetPadding: EdgeInsets.all(28.0),
              //scrollable: true,

              child: Container(
                //height: 80.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Icon(
                      Icons.check,
                      size: 50.0,
                      color: colorMedico,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Uploaded...$songsCount of $songsCount',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.0,
                              child: submitButton('OK', () {
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                    context, 'listSongsPage');
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      errorPopUp(context, 'Songs not uploaded');
    }
  }
}
