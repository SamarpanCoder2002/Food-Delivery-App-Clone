import 'package:http/http.dart' as http;

Future<dynamic> getStoreCollectionData() async {
  final http.Response response =
      await http.get(Uri.parse('API-Link'), headers: {
    'token': 'token_link',
  });

  print('Response: $response');

  return response.body;
}

Future<dynamic> getFoodCategory() async {
  final http.Response response =
      await http.get(Uri.parse('API-Link'), headers: {
    'token': 'token_link',
  });

  print('Response: $response');

  return response.body;
}
