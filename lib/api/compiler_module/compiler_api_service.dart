import 'package:assignment_generator/controller/model/beans.dart';
import 'package:http/http.dart' as http;


// Static class to access compiler service.
class CompilerApiService {
  static const port = '8080';
  static const baseUrl = 'https://3.143.209.60:$port';
  static const compileUrl = '$baseUrl/compile';

  // Submits student files and instructor test file to the compiler. The test
  // file is run and output is returned.
  static Future<String> compileAndGrade(List<FileNameAndBytes> studentFiles) async {
    final request = http.MultipartRequest('POST', Uri.parse(compileUrl));
    for (FileNameAndBytes file in studentFiles) {
      String commonFileName = file.filename.substring(file.filename.indexOf('_') + 1);
      request.files.add(http.MultipartFile.fromBytes(commonFileName, file.bytes, filename: file.filename));
    }
    final streamedResponse = await request.send();
    return await streamedResponse.stream.bytesToString();
  }
}