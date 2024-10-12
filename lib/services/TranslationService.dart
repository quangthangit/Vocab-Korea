import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  Future<String> translateText(String text) async {
    final response = await http.get(Uri.parse(
        'https://translate.googleapis.com/translate_a/single?client=gtx&sl=ko&tl=vi&dt=t&q=$text'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data[0][0][0];
    } else {
      throw Exception('Failed to translate');
    }
  }
}
