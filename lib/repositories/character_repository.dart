import 'package:http/http.dart' as http;

class CharacterRepository {
  final String mainUrl = 'https://rickandmortyapi.com/api/character/';

  Future<http.Response> getData() async {
    final http.Client client = http.Client();

    var str = '';

    for (int i = 0; i < 50; ++i) {
      str += ('$i,');
    }

    final responce = await client.get(Uri.parse('$mainUrl$str'));
    return responce;
  }
}
