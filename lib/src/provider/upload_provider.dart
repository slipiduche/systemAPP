import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UploadProvider {
  Future<Map> upload(String audioPath) async {
    print(audioPath);
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/orbittas-speaker/auto/upload?upload_preset=az4wachs');
    // print(mime(audioPath));
    // final mimeType = mime(audioPath).split('/'); //image/jpeg
    // print(mimeType);
    final audioUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', audioPath,
        contentType: MediaType('audio', 'mpeg'));

    audioUploadRequest.files.add(file);

    final streamResponse = await audioUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Something wrong');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData;
  }
}
