import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:id3/id3.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/provider/upload_provider.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class FilePickerDemo extends StatefulWidget {
  @override
   bool multiple;
   String _text1,_text2;
   FilePickerDemo(this.multiple,this._text1,this._text2, {Key key}) : super(key: key);
  _FilePickerDemoState createState() => _FilePickerDemoState(multiple,_text1,_text2);
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  bool _multiPick;
  String _text1,_text2;
  _FilePickerDemoState(this._multiPick,this._text1,this._text2,);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension='mp3';
  bool _loadingPath = false;
  //bool _multiPick = _multiple;
  FileType _pickingType = FileType.custom;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
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
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: result ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
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
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _text1,
              style: TextStyle(fontSize: 24),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _clearCachedFiles();

                      _openFileExplorer();
                    },
                    child: Container(
                      height: 41.0,
                      width: MediaQuery.of(context).size.width - 52.0,
                      child: Expanded(
                          child: Row(
                        children: [
                          SizedBox(
                            width: 5.0,
                          ),
                          searchIcon(20.0, colorMedico),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            _text2,
                            style: TextStyle(
                                color: colorLetraSearch, fontSize: 24),
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
                  // RaisedButton(
                  //   onPressed: () => _selectFolder(),
                  //   child: Text("Pick folder"),
                  // ),
                  // RaisedButton(
                  //   onPressed: () { _clearCachedFiles();
                  //   setState(() {

                  //   });},
                  //   child: Text("Clear temporary files"),
                  // ),
                ],
              ),
            ),
            Builder(
              builder: (BuildContext context) => _loadingPath
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
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
                          ? Expanded(
                              //   width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height,

                              child: SingleChildScrollView(
                                child: Builder(
                                  // itemCount: _paths != null && _paths.isNotEmpty
                                  //     ? _paths.length
                                  //     : 1,

                                  builder: (BuildContext context) {
                                    final itemCount =
                                        _paths != null && _paths.isNotEmpty
                                            ? _paths.length
                                            : 1;
                                    final bool isMultiPath =
                                        _paths != null && _paths.isNotEmpty;
                                    List<Widget> column = [Container()];

                                    for (var i = 0; i < itemCount; i++) {
                                      final path = _paths
                                          .map((e) => e.path)
                                          .toList()[i]
                                          .toString();
                                      final _selected = i;
                                      //MP3Instance id3=MP3Instance(_paths[index].path);
                                      String
                                          author; //=id3.getMetaTags()['Artist'];
                                      //print(id3.getMetaTags());
                                      if (author == null) {
                                        author = "Unknown";
                                      }
                                      print(author);
                                      column.add(twoIconCard(
                                          _paths[i].name,
                                          author,
                                          songIcon(30.0, colorMedico),
                                          addIcon(30.0, colorMedico),
                                          path,
                                          context));
                                    }

                                    return Column(
                                      children: column,
                                    );
                                  },
                                ),
                              ),
                            )
                          : Expanded(child: const SizedBox()),
            ),
          ],
        ),
      ),
    );
  }

  Widget otro() {
    return Container(
      //   width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _paths != null && _paths.isNotEmpty ? _paths.length : 1,
        itemBuilder: (BuildContext context, int index) {
          final bool isMultiPath = _paths != null && _paths.isNotEmpty;
          final String name = 'File $index: ' +
              (isMultiPath
                  ? _paths.map((e) => e.name).toList()[index]
                  : _fileName ?? '...');
          final path = _paths.map((e) => e.path).toList()[index].toString();
          final _selected = index;
          //MP3Instance id3=MP3Instance(_paths[index].path);
          String author; //=id3.getMetaTags()['Artist'];
          //print(id3.getMetaTags());
          if (author == null) {
            author = "Unknown";
          }
          print(author);

          return twoIconCard(
              _paths[index].name,
              author,
              songIcon(30.0, colorMedico),
              addIcon(30.0, colorMedico),
              path,
              context);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
