import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';

class UploadProvider {
  Future<int> upload(
      String audioPath, String name, String artist, String token) async {
    print(audioPath);
    final url = Uri.parse(
        //'https://api.cloudinary.com/v1_1/orbittas-speaker/auto/upload?upload_preset=az4wachs');
        'http://$serverUri:$uploadPort/upload-audio');
    // print(mime(audioPath));
    // final mimeType = mime(audioPath).split('/'); //image/jpeg
    print(url.port);
    final audioUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('audio', audioPath,
        contentType: MediaType('audio', 'mpeg'));

    //print(ServerDataBloc.tokenS);
    final object = audioUploadRequest.fields['details'] =
        '{"TOKEN":"$token","filename":"$name.mp3","song":"$name","artist":"$artist"}';
    print(object);
    audioUploadRequest.files.add(file);
    print(audioUploadRequest);

    final streamResponse = await audioUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Something wrong');
      print(resp.body);
      return 0;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return 2;
  }
}
