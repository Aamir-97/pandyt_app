import 'package:http/http.dart' as http;

class ApiRepository {
  // Add your API methods here

  Future<dynamic> get(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? response.body : null;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
