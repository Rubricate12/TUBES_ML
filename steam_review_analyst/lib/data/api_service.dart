import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:steam_review_analyst/ui/type/analysis_result.dart';

class ApiService {
  static Future<AnalysisResult?> analyzeReview(String review) async {
    // Change the URL to your Flask server's URL
    final url = Uri.parse('http://192.168.255.137:8000/predict_text');

    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({'text': review});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['prediction'] < 0.5) {
          return AnalysisResult.negative;
        } else {
          return AnalysisResult.positive;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}