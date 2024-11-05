import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future<dynamic> getData() async {
    try {
      // Convert the string URL to a Uri object
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        print('Error: ${response.statusCode}');
        return null; // Return null or handle the error as needed
      }
    } catch (e) {
      print('Caught error: $e');
      return null; // Handle network errors
    }
  }
}
