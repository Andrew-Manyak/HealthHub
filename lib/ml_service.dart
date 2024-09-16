import 'dart:convert';
import 'package:http/http.dart' as http;

class MLService {
  final String apiUrl = '';
  Future<String> getRecommendation(Map<String, dynamic> userResponses) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userResponses),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['recommendation'];
      } else {
        throw Exception('Failed to get recommendation.');
      }
    } catch (e) {
      print('Error: $e');
      return 'Error getting recommendation.';
    }
  }
}
