import 'package:http/http.dart' as http;

Future<dynamic> getStoreCollectionData() async {
  final http.Response response =
      await http.get(Uri.parse('API LINK'), headers: {
    'token': 'token_value',
  });

  print('Response: $response');

  return response.body;
}
