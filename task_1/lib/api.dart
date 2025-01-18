import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchQuizData() async {
  const String url = 'https://api.jsonserve.com/Uw5CrX';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load quiz data');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}
